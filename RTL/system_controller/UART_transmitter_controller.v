module UART_transmitter_controller #(
    parameter DATA_WIDTH = 8
)
(
    input clk,
    input reset,

    // ALU output signals
    input ALU_result_valid,
    input [2 * DATA_WIDTH - 1:0] ALU_result,

    // Register file output signals
    input read_data_valid,
    input [DATA_WIDTH - 1:0] read_data,

    // UART transmitter busy signal after synchronization
    input transmitter_busy_synchronized,
    input transmitter_Q_pulse_generator,

    // UART transmitter data (the data that it will transmit)
    output reg transmitter_parallel_data_valid,
    output reg [DATA_WIDTH - 1:0] transmitter_parallel_data,

    // Enable signal to the receiver to forbid the reception of a new command while the transmission hasn't ended yet
    output reg UART_receiver_controller_enable
);

    reg [2:0] current_state;
    reg [2:0] next_state;
    
    // The output of the combinational logic that produces the vaule of UART_receiver_controller_enable
    reg D_UART_receiver_controller_enable;

    // Register to save the message to be transmitted
    reg [2 * DATA_WIDTH - 1:0] message;

    // The main controller's available states
    localparam [2:0] IDLE = 3'b000;
    localparam [2:0] TRANSMIT_REGISTER_FILE_DATA = 3'b001; 
    localparam [2:0] TRANSMIT_LOWER_ALU_RESULT = 3'b010;
    localparam [2:0] WAIT_FOR_UPPER_ALU_RESULT = 3'b011;
    localparam [2:0] TRANSMIT_UPPER_ALU_RESULT = 3'b100;
    

    // The states of the transmission
    localparam [1:0] NO_TRANSMISSION = 2'b00;
    localparam [1:0] TRANSMISSION_BEGAN = 2'b01;
    localparam [1:0] TRANSMISSION_ENDED = 2'b10;
    // This FSM is instantiated because the singnal 'busy' from the UART transmitter
    // is sent to the controller by using a bit synchronizer and the transmitter is 
    // very much slower than the controller so the controller must hold the parallel data
    // and the valid signal until the following sequence occurs:
    // busy: 0 --> 1 --> 0
    // If the data isn't held until this sequence occurs, then the transmission process
    // will fail every time.
    
    reg [1:0] transmission_current_state;
    reg [1:0] transmission_next_state;


    //------------------------------------ Main FSM -------------------------------------
    // Main state transition logic
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            message <= 'b0;
        end
        else if (read_data_valid) begin
            message <= read_data;
        end
        else if (ALU_result_valid) begin
            message <= ALU_result;
        end
    end
    
    // Next main state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (~transmitter_busy_synchronized) begin
                    if (read_data_valid) begin
                        next_state = TRANSMIT_REGISTER_FILE_DATA;
                    end
                    else if (ALU_result_valid) begin
                        next_state = TRANSMIT_LOWER_ALU_RESULT;
                    end
                    else begin
                        next_state = IDLE;
                    end
                end
                else begin
                    next_state = IDLE;
                end
            end

            TRANSMIT_REGISTER_FILE_DATA: begin
                if (transmission_current_state != TRANSMISSION_ENDED) begin
                    next_state = TRANSMIT_REGISTER_FILE_DATA;
                end
                else begin
                    next_state = IDLE;
                end
            end

            TRANSMIT_LOWER_ALU_RESULT: begin
                if (transmission_current_state != TRANSMISSION_ENDED) begin
                    next_state = TRANSMIT_LOWER_ALU_RESULT;
                end
                else begin
                    next_state = WAIT_FOR_UPPER_ALU_RESULT;
                end
            end

            WAIT_FOR_UPPER_ALU_RESULT: begin
                if (~transmitter_Q_pulse_generator) begin
                    next_state = TRANSMIT_UPPER_ALU_RESULT;
                end
                else begin
                    next_state = WAIT_FOR_UPPER_ALU_RESULT;
                end
            end

            TRANSMIT_UPPER_ALU_RESULT: begin
                if (transmission_current_state != TRANSMISSION_ENDED) begin
                    next_state = TRANSMIT_UPPER_ALU_RESULT;
                end
                else begin
                    next_state = IDLE;
                end
            end


            default: begin
                next_state = IDLE;
            end
        endcase
    end


    // Output logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                transmitter_parallel_data_valid = 1'b0;
                transmitter_parallel_data = 'b0;
                D_UART_receiver_controller_enable = 1'b1;
            end

            TRANSMIT_REGISTER_FILE_DATA: begin
                transmitter_parallel_data_valid = 1'b1;
                transmitter_parallel_data = message[DATA_WIDTH - 1:0];
                D_UART_receiver_controller_enable = 1'b0;
            end

            TRANSMIT_LOWER_ALU_RESULT: begin
                transmitter_parallel_data_valid = 1'b1;
                transmitter_parallel_data = message[DATA_WIDTH - 1:0];
                D_UART_receiver_controller_enable = 1'b0;
            end

            WAIT_FOR_UPPER_ALU_RESULT: begin
                transmitter_parallel_data_valid = 1'b0;
                transmitter_parallel_data = 'b0;
                D_UART_receiver_controller_enable = 1'b0;
            end

            TRANSMIT_UPPER_ALU_RESULT: begin
                transmitter_parallel_data_valid = 1'b1;
                transmitter_parallel_data = message[2 * DATA_WIDTH - 1:DATA_WIDTH];
                D_UART_receiver_controller_enable = 1'b0;
            end

            default: begin
                transmitter_parallel_data_valid = 1'b0;
                transmitter_parallel_data = 'b0;
                D_UART_receiver_controller_enable = 1'b1;
            end
        endcase
    end

    // Register to save the value of UART_receiver_controller_enable, so that on resetting the system,
    // the enable has a defined value (1) instead of (x)
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            UART_receiver_controller_enable <= 1'b1;
        end
        else begin
            UART_receiver_controller_enable <= D_UART_receiver_controller_enable;
        end
    end
    // -------------------------------------------------------------------------------------

    //---------------------------------- Transmission FSM ----------------------------------
    // Transmission state transition logic
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            transmission_current_state <= NO_TRANSMISSION;
        end
        else begin
            transmission_current_state <= transmission_next_state;
        end
    end

    // Next transmission state logic
    always @(*) begin
        case (transmission_current_state)
            NO_TRANSMISSION: begin
                if (transmitter_busy_synchronized) begin
                    transmission_next_state = TRANSMISSION_BEGAN;
                end
                else begin
                    transmission_next_state = NO_TRANSMISSION;
                end
            end
            
            TRANSMISSION_BEGAN: begin
                if (~transmitter_busy_synchronized) begin
                    transmission_next_state = TRANSMISSION_ENDED;
                end
                else begin
                    transmission_next_state = TRANSMISSION_BEGAN;
                end
            end

            // The controller is much faster than the transmitter so it is not possible
            // that the 'busy' signal was low the last cycle (this what made the system
            // reach this state) and then it is high at this cycle.
            TRANSMISSION_ENDED: begin
                transmission_next_state = NO_TRANSMISSION;
            end

            default: begin
                transmission_next_state = NO_TRANSMISSION;
            end
        endcase
    end
    // -------------------------------------------------------------------------------------

endmodule