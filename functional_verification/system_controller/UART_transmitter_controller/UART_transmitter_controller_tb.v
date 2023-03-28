`include "../../../RTL/system_controller/UART_transmitter_controller.v"
`timescale 1ns/1ps

module UART_transmitter_controller_tb;
    
    parameter DATA_WIDTH = 8;

    // The frequency of the reference clock is 40 MHz, period = 25 ns
    localparam REFERENCE_CLK_PERIOD = 25;

    // The clock period of the UART transmitter is = (271 ns) * 32 = 8672 ns
    localparam TRANSMITTER_CLK_PERIOD = 8680;

    // Input signals' declaration
    reg reference_clk_tb;
    reg reset_tb;
    reg [2 * DATA_WIDTH - 1:0] ALU_result_tb;
    reg ALU_result_valid_tb;
    reg [DATA_WIDTH - 1:0] read_data_tb;
    reg read_data_valid_tb;
    reg transmitter_busy_synchronized_tb;
    reg transmitter_Q_pulse_generator_tb;

    // Output signals' declaration
    wire [DATA_WIDTH - 1:0] transmitter_parallel_data_tb;
    wire transmitter_parallel_data_valid_tb;
    wire UART_receiver_controller_enable_tb;

    integer i;
    reg result;
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

        // Test case (1)
        ALU_result_valid_tb = 1'b1;
        ALU_result_tb = 'b1110_0111_1010_0110;

        #(3 * TRANSMITTER_CLK_PERIOD);
        transmitter_Q_pulse_generator_tb = 1'b1;
        transmitter_busy_synchronized_tb = 1'b1;

        #(12 * TRANSMITTER_CLK_PERIOD);
        if (transmitter_parallel_data_tb == ALU_result_tb[7:0]) begin
            result = 1;
        end
        else begin
            $fdisplay(file, "%8b", transmitter_parallel_data_tb);
            result = 0;
        end

        transmitter_busy_synchronized_tb = 1'b0;
        ALU_result_valid_tb = 1'b0;
        transmitter_Q_pulse_generator_tb = 1'b0;

        #(2 * TRANSMITTER_CLK_PERIOD);
        ALU_result_valid_tb = 1'b1;
        transmitter_Q_pulse_generator_tb = 1'b1;
        
        #TRANSMITTER_CLK_PERIOD;
        transmitter_busy_synchronized_tb = 1'b1;
        
        #(12 * TRANSMITTER_CLK_PERIOD);
        if (transmitter_parallel_data_tb != ALU_result_tb[15:8]) begin
            $fdisplay(file, "%8b", transmitter_parallel_data_tb);
            result = 0;
        end
        transmitter_busy_synchronized_tb = 1'b0;

        if (result) begin
            $fdisplay(file, "Test case (%0d) passed.", 1);
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (%0d) failed.", 1);
        end
        total_test_cases = total_test_cases + 1;

        // Test case (2)
        ALU_result_valid_tb = 1'b0;
        read_data_valid_tb = 1'b1;
        read_data_tb = 8'b0111_1001;

        #(3 * TRANSMITTER_CLK_PERIOD);
        transmitter_busy_synchronized_tb = 1'b1;

        #(12 * TRANSMITTER_CLK_PERIOD);
        if (transmitter_parallel_data_tb == read_data_tb) begin
            $fdisplay(file, "Test case (%0d) passed.", 2);
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (%0d) failed.", 2);
            $fdisplay(file, "%8b", transmitter_parallel_data_tb);
        end
        total_test_cases = total_test_cases + 1;

        $fdisplay(file, "Total: %0d/%0d", passed_test_cases, total_test_cases);

        $stop;
    end



    // Initialize all the input signals
    task initialize();
    begin
        reference_clk_tb = 1'b0;
        reset_tb = 1'b1;
        ALU_result_tb = 'b0;
        ALU_result_valid_tb = 1'b0;
        read_data_tb = 'b0;
        read_data_valid_tb = 1'b0;
        transmitter_busy_synchronized_tb = 1'b0;
        transmitter_Q_pulse_generator_tb = 1'b0;
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
    UART_transmitter_controller #(
        .DATA_WIDTH(DATA_WIDTH)
    ) U_UART_transmitter_controller(
        .clk(reference_clk_tb),
        .reset(reset_tb),
        .ALU_result_valid(ALU_result_valid_tb),
        .ALU_result(ALU_result_tb),
        .read_data_valid(read_data_valid_tb),
        .read_data(read_data_tb),
        .transmitter_busy_synchronized(transmitter_busy_synchronized_tb),
        .transmitter_Q_pulse_generator(transmitter_Q_pulse_generator_tb),

        .transmitter_parallel_data_valid(transmitter_parallel_data_valid_tb),
        .transmitter_parallel_data(transmitter_parallel_data_tb),
        .UART_receiver_controller_enable(UART_receiver_controller_enable_tb)
    );
endmodule