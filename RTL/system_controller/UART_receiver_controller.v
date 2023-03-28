module UART_receiver_controller #(
    parameter DATA_WIDTH = 8,
    parameter REGISTER_FILE_DEPTH = 16
)
(
    input clk,
    input reset,
    input enable,

    input parallel_data_valid_synchronized,
    input [DATA_WIDTH - 1:0] parallel_data_synchronized,

    // ALU control signals
    output reg [3:0] ALU_function,
    output reg ALU_enable,
    output reg ALU_clk_enable,

    // Register file control signals
    output reg [$clog2(REGISTER_FILE_DEPTH) - 1:0] address,
    output reg write_enable,
    output reg [DATA_WIDTH - 1:0] write_data,
    output reg read_enable
);

    // A register to save the register file write address becuase the address frame
    // is followed by the data frame.
    reg [$clog2(REGISTER_FILE_DEPTH) - 1:0] Q_write_address_register;
    reg enable_write_address_register;

    // Counter to count the cycles passed in the 'EVALUATE_RESULT' state
    reg [1:0] counter;

    // Supported commands encoding
    localparam [DATA_WIDTH - 1:0] REGISTER_FILE_WRITE_COMMAND = 'hAA;
    localparam [DATA_WIDTH - 1:0] REGISTER_FILE_READ_COMMAND = 'hBB;
    localparam [DATA_WIDTH - 1:0] ALU_OPERATION_WITH_OPERANDS_COMMAND = 'hCC;
    localparam [DATA_WIDTH - 1:0] ALU_OPERATION_WITHOUT_OPERANDS_COMMAND = 'hDD;

    localparam [$clog2(REGISTER_FILE_DEPTH) - 1:0] OPERAND_A_ADDRESS = 'b0;
    localparam [$clog2(REGISTER_FILE_DEPTH) - 1:0] OPERAND_B_ADDRESS = 'b1;
    

    reg [2:0] current_state;
    reg [2:0] next_state;

    // FSM state encoding
    localparam [2:0] IDLE = 3'b000;
    localparam [2:0] WAIT_FOR_WRITE_ADDRESS = 3'b001;
    localparam [2:0] WAIT_FOR_WRITE_DATA = 3'b010;
    localparam [2:0] WAIT_FOR_READ_ADDRESS = 3'b011;
    localparam [2:0] WAIT_FOR_OPERAND_A_DATA = 3'b100;
    localparam [2:0] WAIT_FOR_OPERAND_B_DATA = 3'b101;
    localparam [2:0] WAIT_FOR_ALU_FUNCTION = 3'b110;
    localparam [2:0] EVALUATE_RESULT = 3'b111;


    // State transition logic
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (enable & parallel_data_valid_synchronized) begin
                    case (parallel_data_synchronized) 
                        REGISTER_FILE_WRITE_COMMAND: begin
                            next_state = WAIT_FOR_WRITE_ADDRESS;
                        end

                        REGISTER_FILE_READ_COMMAND: begin
                            next_state = WAIT_FOR_READ_ADDRESS;
                        end

                        ALU_OPERATION_WITH_OPERANDS_COMMAND: begin
                            next_state = WAIT_FOR_OPERAND_A_DATA;
                        end

                        ALU_OPERATION_WITHOUT_OPERANDS_COMMAND: begin
                            next_state = WAIT_FOR_ALU_FUNCTION;
                        end

                        default: begin
                            next_state = IDLE;
                        end
                    endcase
                end
                else begin
                    next_state = IDLE;
                end
            end
            //--------------------------------------------------------------------------
            WAIT_FOR_WRITE_ADDRESS: begin
                if (parallel_data_valid_synchronized) begin
                    next_state = WAIT_FOR_WRITE_DATA;
                end
                else begin
                    next_state = WAIT_FOR_WRITE_ADDRESS;
                end
            end

            WAIT_FOR_WRITE_DATA: begin
                if (parallel_data_valid_synchronized) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = WAIT_FOR_WRITE_DATA;
                end
            end

            //--------------------------------------------------------------------------
            WAIT_FOR_READ_ADDRESS: begin
                if (parallel_data_valid_synchronized) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = WAIT_FOR_READ_ADDRESS;
                end
            end

            //--------------------------------------------------------------------------
            WAIT_FOR_OPERAND_A_DATA: begin
                if (parallel_data_valid_synchronized) begin
                    next_state = WAIT_FOR_OPERAND_B_DATA;
                end
                else begin
                    next_state = WAIT_FOR_OPERAND_A_DATA;
                end
            end

            WAIT_FOR_OPERAND_B_DATA: begin
                if (parallel_data_valid_synchronized) begin
                    next_state = WAIT_FOR_ALU_FUNCTION;
                end
                else begin
                    next_state = WAIT_FOR_OPERAND_B_DATA;
                end
            end

            WAIT_FOR_ALU_FUNCTION: begin
                if (parallel_data_valid_synchronized) begin
                    next_state = EVALUATE_RESULT;
                end
                else begin
                    next_state = WAIT_FOR_ALU_FUNCTION;
                end
            end

            EVALUATE_RESULT: begin
                next_state = IDLE;
            end
        endcase
    end

    // Write address register (for register file write command)
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            Q_write_address_register <= 'b0;
        end
        else if (enable_write_address_register) begin
            Q_write_address_register <= parallel_data_synchronized[$clog2(REGISTER_FILE_DEPTH) - 1:0];
        end
    end
    

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            counter <= 2'b00;
        end
        else if (parallel_data_valid_synchronized) begin
            counter <= 2'b01;
        end
        else if (current_state == EVALUATE_RESULT) begin
            counter <= 2'b10;
        end
        else begin
            counter <= 2'b00;
        end
    end

    // Output logic
    always @(*) begin
        // default values for outputs
        ALU_function = 4'b0;
        ALU_enable = 1'b0;
        ALU_clk_enable = 1'b0;
        enable_write_address_register = 1'b0;
        address = 'b0;
        write_enable = 1'b0;
        write_data = 'b0;
        read_enable = 1'b0;

        case (current_state)
            IDLE: begin
                if (counter == 2'b10) begin
                    ALU_clk_enable = 1'b1;
                end
                else begin
                    ALU_clk_enable = 1'b0;
                end
            end

            WAIT_FOR_WRITE_ADDRESS: begin
                if (parallel_data_valid_synchronized & counter == 2'b00) begin
                    enable_write_address_register = 1'b1;
                end
                else begin
                    enable_write_address_register = 1'b0;
                end
            end

            WAIT_FOR_WRITE_DATA: begin
                if (parallel_data_valid_synchronized & counter == 2'b00) begin
                    address = Q_write_address_register;
                    write_enable = 1'b1;
                    write_data = parallel_data_synchronized;
                end
                else begin
                    address = 'b0;
                    write_enable = 1'b0;
                    write_data = 'b0;
                end
            end
            //--------------------------------------------------------------------------
            WAIT_FOR_READ_ADDRESS: begin
                if (parallel_data_valid_synchronized & counter == 2'b00) begin
                    address = parallel_data_synchronized[$clog2(REGISTER_FILE_DEPTH) - 1:0];
                    read_enable = 1'b1;
                end
                else begin
                    address = 'b0;
                    read_enable = 1'b0;
                end
            end
            //--------------------------------------------------------------------------
            WAIT_FOR_OPERAND_A_DATA: begin
                if (parallel_data_valid_synchronized & counter == 2'b00) begin
                    read_enable = 1'b0;
                    address = OPERAND_A_ADDRESS;
                    write_enable = 1'b1;
                    write_data = parallel_data_synchronized;
                end
                else begin
                    read_enable = 1'b0;
                    address = 'b0;
                    write_enable = 1'b0;
                    write_data = 'b0;
                end
            end

            WAIT_FOR_OPERAND_B_DATA: begin
                if (parallel_data_valid_synchronized & counter == 2'b00) begin
                    read_enable = 1'b0;
                    address = OPERAND_B_ADDRESS;
                    write_enable = 1'b1;
                    write_data = parallel_data_synchronized;
                end
                else begin
                    read_enable = 1'b0;
                    address = 'b0;
                    write_enable = 1'b0;
                    write_data = 'b0;
                end
            end

            WAIT_FOR_ALU_FUNCTION: begin
                if (parallel_data_valid_synchronized & counter == 2'b00) begin
                    ALU_clk_enable = 1'b1;
                end
                else begin
                    ALU_clk_enable = 1'b0;
                end
            end

            EVALUATE_RESULT: begin
                ALU_clk_enable = 1'b1;
                ALU_enable = 1'b1;
                ALU_function = parallel_data_synchronized[3:0];
            end
            //--------------------------------------------------------------------------
        endcase
    end
endmodule