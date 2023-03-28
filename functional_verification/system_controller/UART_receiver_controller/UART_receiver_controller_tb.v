`include "../../../RTL/system_controller/UART_receiver_controller.v"
`timescale 1ns/1ps

module UART_receiver_controller_tb;
    
    parameter DATA_WIDTH = 8;
    parameter REGISTER_FILE_DEPTH = 16;

    // The frequency of the reference clock is 40 MHz, period = 25 ns
    localparam REFERENCE_CLK_PERIOD = 25;

    // The frequency of the UART receiver clock is 3686.4 KHz, period = 271 ns
    localparam RECEIVER_CLK_PERIOD = 271;

    // Supported commands encoding
    localparam [DATA_WIDTH - 1:0] REGISTER_FILE_WRITE_COMMAND = 'hAA;
    localparam [DATA_WIDTH - 1:0] REGISTER_FILE_READ_COMMAND = 'hBB;
    localparam [DATA_WIDTH - 1:0] ALU_OPERATION_WITH_OPERANDS_COMMAND = 'hCC;
    localparam [DATA_WIDTH - 1:0] ALU_OPERATION_WITHOUT_OPERANDS_COMMAND = 'hDD;

    // Input signals' declaration
    reg reference_clk_tb;
    reg reset_tb;
    reg enable_tb;
    reg parallel_data_valid_synchronized_tb;
    reg [DATA_WIDTH - 1:0] parallel_data_synchronized_tb;

    // Output signals' declaration
    wire [3:0] ALU_function_tb;
    wire ALU_enable_tb;
    wire ALU_clk_enable_tb;
    wire [$clog2(REGISTER_FILE_DEPTH) - 1:0] address_tb;
    wire write_enable_tb;
    wire [DATA_WIDTH - 1:0] write_data_tb;
    wire read_enable_tb;

    integer i;
    integer passed_test_cases;
    integer total_test_cases;

    // Output file
    integer file;


    initial begin
        $timeformat(-9, 2, " ns", 20);
        file = $fopen("output.txt", "w");
        passed_test_cases = 0;
        total_test_cases = 0;
        
        initialize();
        reset();
        enable_tb = 1'b1;
        
        // Test case (1)
        // command code message
        @(posedge reference_clk_tb)
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb = REGISTER_FILE_WRITE_COMMAND;
        
        // data valid cycle
        #(REFERENCE_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b0;

        // address message
        #(12 * RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb = 'b0000_1101;
        
        // data valid cycle
        #(REFERENCE_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b0;


        // write data message
        #(12 * RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb <= 'b1100_1111;
        
        #(REFERENCE_CLK_PERIOD / 2.0);

        if (address_tb == 'b1101 && write_data_tb == 'b1100_1111) begin
            $fdisplay(file, "Test case (%0d) passed.", 1);
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (%0d) failed.", 1);
        end

        // data valid cycle
        #(12 * RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb = 1'b0;
        #(RECEIVER_CLK_PERIOD)

        total_test_cases = total_test_cases + 1;
        //-------------------------------------------------------------------

        // Test case (2)
        // command code message
        @(posedge reference_clk_tb)
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb <= REGISTER_FILE_READ_COMMAND;
        
        // data valid cycle
        #(REFERENCE_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b0;

        // address message
        #(12 * RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb <= 'b0000_1000;
        
        #(REFERENCE_CLK_PERIOD / 2.0);

        if (address_tb == 'b1000 && read_enable_tb == 1'b1) begin
            $fdisplay(file, "Test case (%0d) passed.", 2);
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (%0d) failed.", 2);
        end

        // data valid cycle
        #(RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb = 1'b0;

        #(RECEIVER_CLK_PERIOD)

        total_test_cases = total_test_cases + 1;
        //-------------------------------------------------------------------

        // Test case (3)
        // command code message
        @(posedge reference_clk_tb)
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb <= ALU_OPERATION_WITH_OPERANDS_COMMAND;
        
        // data valid cycle
        #(REFERENCE_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b0;

        // operand A message
        #(12 * RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb <= 'b0000_1001;
        
        // data valid cycle
        #(REFERENCE_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b0;


        // operand B message
        #(12 * RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb <= 'b0000_1010;
        
        // data valid cycle
        #(REFERENCE_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b0;


        // ALU function message
        #(12 * RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb <= 'b0000_0100;
        
        #(REFERENCE_CLK_PERIOD * 1.5);
        if (ALU_function_tb == 'b0100 && ALU_enable_tb == 1'b1 && ALU_clk_enable_tb == 1'b1) begin
            $fdisplay(file, "Test case (%0d) passed.", 3);
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (%0d) failed.", 3);
        end

        // data valid cycle
        #(RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb = 1'b0;
        

        #(RECEIVER_CLK_PERIOD)

        total_test_cases = total_test_cases + 1;
        //-------------------------------------------------------------------

        // Test case (4)
        // command code message
        @(posedge reference_clk_tb)
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb <= ALU_OPERATION_WITHOUT_OPERANDS_COMMAND;
        
        // data valid cycle
        #(REFERENCE_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b0;

        // ALU funtion message
        #(12 * RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb <= 1'b1;
        parallel_data_synchronized_tb <= 'b0000_1110;
        
        #(REFERENCE_CLK_PERIOD * 1.5);
        if (ALU_function_tb == 'b1110 && ALU_enable_tb == 1'b1 && ALU_clk_enable_tb == 1'b1) begin
            $fdisplay(file, "Test case (%0d) passed.", 4);
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (%0d) failed.", 4);
        end

        // data valid cycle
        #(RECEIVER_CLK_PERIOD);
        parallel_data_valid_synchronized_tb = 1'b0;

        #(RECEIVER_CLK_PERIOD)

        total_test_cases = total_test_cases + 1;
        //-------------------------------------------------------------------

        $fdisplay(file, "Total: %0d/%0d", passed_test_cases, total_test_cases);

        $stop;
    end
        
    // Initialize all the input signals
    task initialize();
    begin
        reference_clk_tb = 1'b0;
        reset_tb = 1'b1;
        enable_tb = 1'b0;
        parallel_data_valid_synchronized_tb = 1'b0;
        parallel_data_synchronized_tb = 'b0;
    end
    endtask

    // Reset the system in one clock cycle
    task reset();
    begin
        #REFERENCE_CLK_PERIOD
        reset_tb = 1'b0;
        #REFERENCE_CLK_PERIOD
        reset_tb = 1'b1;
    end
    endtask

    // reference clock generator
    always #(REFERENCE_CLK_PERIOD / 2.0) reference_clk_tb = ~reference_clk_tb;

    // DUT instantiation
    UART_receiver_controller #(
        .DATA_WIDTH(DATA_WIDTH),
        .REGISTER_FILE_DEPTH(REGISTER_FILE_DEPTH)
    ) U_UART_receiver_controller(
        .clk(reference_clk_tb),
        .reset(reset_tb),
        .enable(enable_tb),
        .parallel_data_valid_synchronized(parallel_data_valid_synchronized_tb),
        .parallel_data_synchronized(parallel_data_synchronized_tb),

        .ALU_function(ALU_function_tb),
        .ALU_enable(ALU_enable_tb),
        .ALU_clk_enable(ALU_clk_enable_tb),
        .address(address_tb),
        .write_enable(write_enable_tb),
        .write_data(write_data_tb),
        .read_enable(read_enable_tb)
    );
endmodule