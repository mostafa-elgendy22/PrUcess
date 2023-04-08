`include "../../../RTL/UART/UART_transmitter/UART_transmitter.v"
`timescale 1ns/1ps

module UART_transmitter_tb;

    parameter DATA_WIDTH = 8;

    // Input signals' declaration
    reg clk_tb;
    reg reset_tb;
    reg parity_type_tb;
    reg parity_enable_tb;
    reg data_valid_tb;
    reg [DATA_WIDTH - 1:0] parallel_data_tb;

    // Output signals' declaration
    wire serial_data_out_tb;
    wire busy_tb;

    // A variable to store all the bits transmitted serially from the transmitter
    reg [DATA_WIDTH + 2:0] transmitter_output;


    integer i;
    integer passed_test_cases;
    integer total_test_cases;

    // Output file
    integer file;

    localparam CLK_PERIOD = 8762;



    initial 
    begin
        $timeformat(-9, 2, " ns", 20);
        file = $fopen("output.txt", "w");
        passed_test_cases = 0;
        total_test_cases = 0;
        
        initialize();
        reset();

        $display("--------------------- Test case (1) ---------------------");
        parity_type_tb = 1'b0;
        parity_enable_tb = 1'b1;
        data_valid_tb = 1'b1;
        parallel_data_tb = 'hE6;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, parallel_data = %2h", 
                  parity_enable_tb, parallel_data_tb);
        #CLK_PERIOD
        data_valid_tb = 1'b0;
        transmitter_output[0] = serial_data_out_tb;

        for (i = 1; i <= DATA_WIDTH + 2; i = i + 1)
        begin
            #CLK_PERIOD
            transmitter_output[i] = serial_data_out_tb;
        end

        $display("time = %0t", $time);
        $display("Serial data transmitted = %2h", transmitter_output[DATA_WIDTH:1]);
        if (transmitter_output == {1'b1, ^parallel_data_tb, parallel_data_tb, 1'b0})
        begin
            $display("Test case (1) passed.");
            $fdisplay(file, "Test case (1) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else
        begin
            $display("Test case (1) failed.");
            $display("transmitter output = %b", transmitter_output);
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (1) failed.");
            $fdisplay(file, "transmitter output = %b", transmitter_output);
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        // Wait for the transmitter to enter the IDLE state
        #CLK_PERIOD


        $display("--------------------- Test case (2) ---------------------");
        parity_type_tb = 1'b1;
        parity_enable_tb = 1'b1;
        data_valid_tb = 1'b1;
        parallel_data_tb = 'hFF;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, parallel_data = %2h", 
                  parity_enable_tb, parallel_data_tb);
        #CLK_PERIOD
        data_valid_tb = 1'b0;
        transmitter_output[0] = serial_data_out_tb;
        for (i = 1; i <= DATA_WIDTH + 2; i = i + 1)
        begin
            #CLK_PERIOD
            transmitter_output[i] = serial_data_out_tb;
        end

        $display("time = %0t", $time);
        $display("Serial data transmitted = %2h", transmitter_output[DATA_WIDTH:1]);
        if (transmitter_output == {1'b1, ~^parallel_data_tb, parallel_data_tb, 1'b0})
        begin
            $display("Test case (2) passed.");
            $fdisplay(file, "Test case (2) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else
        begin
            $display("Test case (2) failed.");
            $display("transmitter output = %b", transmitter_output);
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (2) failed.");
            $fdisplay(file, "transmitter output = %b", transmitter_output);
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        // Wait for the transmitter to enter the IDLE state
        #CLK_PERIOD

        $display("--------------------- Test case (3) ---------------------");
        parity_type_tb = 1'b0;
        parity_enable_tb = 1'b0;
        data_valid_tb = 1'b1;
        parallel_data_tb = 'hF4;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, parallel_data = %2h", 
                  parity_enable_tb, parallel_data_tb);
        #CLK_PERIOD
        data_valid_tb = 1'b0;
        transmitter_output[0] = serial_data_out_tb;
        for (i = 1; i <= DATA_WIDTH + 1; i = i + 1)
        begin
            #CLK_PERIOD
            transmitter_output[i] = serial_data_out_tb;
        end

        $display("time = %0t", $time);
        $display("Serial data transmitted = %2h", transmitter_output[DATA_WIDTH + 2:1]);
        if (transmitter_output[DATA_WIDTH + 1:0] == {1'b1, parallel_data_tb, 1'b0})
        begin
            $display("Test case (3) passed.");
            $fdisplay(file, "Test case (3) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else
        begin
            $display("Test case (3) failed.");
            $display("transmitter output = %b", transmitter_output);
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (3) failed.");
            $fdisplay(file, "transmitter output = %b", transmitter_output);
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        $fdisplay(file, "Total: %0d/%0d.", passed_test_cases, total_test_cases);

        $stop;

    end

    // Initialize all the input signals
    task initialize();
    begin
        clk_tb = 1'b0;
        reset_tb = 1'b1;
        parity_type_tb = 1'b0;
        parity_enable_tb = 1'b0;
        data_valid_tb = 1'b0;
        parallel_data_tb = 8'b0;
    end
    endtask

    // Reset the system in one clock cycle
    task reset();
    begin
        #CLK_PERIOD
        reset_tb = 1'b0;
        #CLK_PERIOD
        reset_tb = 1'b1;
    end
    endtask

    // Clock generator
    always #(CLK_PERIOD / 2.0) clk_tb = ~clk_tb;


    // UART transmitter top module instantiation
    UART_transmitter #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_UART_transmitter (
        .clk(clk_tb),
        .reset(reset_tb),
        .parity_type(parity_type_tb),
        .parity_enable(parity_enable_tb),
        .data_valid(data_valid_tb),
        .parallel_data(parallel_data_tb),

        .serial_data_out(serial_data_out_tb),
        .busy(busy_tb)
    );

endmodule