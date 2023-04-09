`include "../../../RTL/UART/UART_receiver/UART_receiver.v"
`timescale 1ns/1ps

module UART_receiver_tb;

    parameter DATA_WIDTH = 8;

    // Input signals' declaration
    reg clk_tb;
    reg reset_tb;
    reg parity_type_tb;
    reg parity_enable_tb;
    reg [5:0] prescale_tb;
    reg serial_data_in_tb;


    // Output signals' declaration
    wire data_valid_tb;
    wire [DATA_WIDTH - 1:0] parallel_data_tb;
    wire parity_error_tb;
    wire frame_error_tb;

    reg [DATA_WIDTH - 1:0] transmitted_byte;
    reg [DATA_WIDTH + 2:0] transmitted_frame;


    integer i;
    integer file;
    integer passed_test_cases;
    integer total_test_cases;

    localparam RECEIVER_CLK_PERIOD = 271;


    initial 
    begin
        $timeformat(-9, 2, " ns", 20);
        file = $fopen("output.txt", "w");
        passed_test_cases = 0;
        total_test_cases = 0;

        initialize();
        reset();

        $display("--------------------- Test case (1) ---------------------");
        parity_enable_tb = 1'b1;
        parity_type_tb = 1'b0;
        transmitted_byte = 'h6A;
        transmitted_frame = {1'b1, ^transmitted_byte, transmitted_byte, 1'b0};
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, prescale = %6b", 
                  parity_enable_tb, prescale_tb);
        
        // Stop bit (IDLE)
        serial_data_in_tb = 1'b1;
        #RECEIVER_CLK_PERIOD
        
        for (i = 0; i <= DATA_WIDTH + 2; i = i + 1) begin
            serial_data_in_tb = transmitted_frame[i];
            #(prescale_tb * RECEIVER_CLK_PERIOD);
        end

        $display("time = %0t", $time);
        $display("Transmitted data = %2h", transmitted_byte);
        $display("Received data = %2h", parallel_data_tb);
        
        // Wait 1 cycle for the DATA_VALID state
        #(1 * RECEIVER_CLK_PERIOD)

        if (parallel_data_tb == transmitted_byte && data_valid_tb == 1'b1) begin
            $display("Test case (1) passed.");
            $fdisplay(file, "Test case (1) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $display("Test case (1) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (1) failed.");
            $fdisplay(file, "parallel data = %b, data_valid = %b", parallel_data_tb, data_valid_tb);
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");
        
        serial_data_in_tb = 1'b1;
        #(4 * RECEIVER_CLK_PERIOD);

        $display("--------------------- Test case (2) ---------------------");
        parity_enable_tb = 1'b0;
        transmitted_byte = 'hA5;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, prescale = %6b", 
                  parity_enable_tb, prescale_tb);
        
        serial_data_in_tb = 1'b0;
        #(prescale_tb * RECEIVER_CLK_PERIOD);

        for (i = 0; i <= DATA_WIDTH - 1; i = i + 1) begin
            serial_data_in_tb = transmitted_byte[i];
            #(prescale_tb * RECEIVER_CLK_PERIOD);
        end

        serial_data_in_tb = 1'b1;
        #(prescale_tb * RECEIVER_CLK_PERIOD);

        $display("time = %0t", $time);
        $display("Transmitted data = %2h", transmitted_byte);
        $display("Received data = %2h", parallel_data_tb);

        // Wait 1 cycle for the DATA_VALID state
        #(1 * RECEIVER_CLK_PERIOD)

        if (parallel_data_tb == transmitted_byte && data_valid_tb == 1'b1) begin
            $display("Test case (2) passed.");
            $fdisplay(file, "Test case (2) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $display("Test case (2) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (2) failed.");
            $fdisplay(file, "parallel data = %b, data_valid = %b", parallel_data_tb, data_valid_tb);
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        serial_data_in_tb = 1'b1;
        #(4 * RECEIVER_CLK_PERIOD);
        
        $display("--------------------- Test case (3) ---------------------");
        parity_enable_tb = 1'b1;
        parity_type_tb = 1'b1;
        transmitted_byte = 'hF7;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, prescale = %6b", 
                  parity_enable_tb, prescale_tb);
        
        serial_data_in_tb = 1'b0;
        #(prescale_tb * RECEIVER_CLK_PERIOD);

        for (i = 0; i <= DATA_WIDTH - 1; i = i + 1) begin
            serial_data_in_tb = transmitted_byte[i];
            #(prescale_tb * RECEIVER_CLK_PERIOD);
        end

        serial_data_in_tb = ~^transmitted_byte;
        #(prescale_tb * RECEIVER_CLK_PERIOD);

        serial_data_in_tb = 1'b1;
        #(prescale_tb * RECEIVER_CLK_PERIOD);

        $display("time = %0t", $time);
        $display("Transmitted data = %2h", transmitted_byte);
        $display("Received data = %2h", parallel_data_tb);

        // Wait 1 cycle for the DATA_VALID state
        #(1 * RECEIVER_CLK_PERIOD)

        if (parallel_data_tb == transmitted_byte && data_valid_tb == 1'b1) begin
            $display("Test case (3) passed.");
            $fdisplay(file, "Test case (3) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $display("Test case (3) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (3) failed.");
            $fdisplay(file, "parallel data = %b, data_valid = %b", parallel_data_tb, data_valid_tb);
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        serial_data_in_tb = 1'b1;
        #(4 * RECEIVER_CLK_PERIOD);

        $display("--------------------- Test case (4) ---------------------");
        parity_enable_tb = 1'b0;
        transmitted_byte = 'h5A;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, prescale = %6b", 
                  parity_enable_tb, prescale_tb);
        
        serial_data_in_tb = 1'b0;
        #(prescale_tb * RECEIVER_CLK_PERIOD);

        for (i = 0; i <= DATA_WIDTH - 1; i = i + 1) begin
            serial_data_in_tb = transmitted_byte[i];
            #(prescale_tb * RECEIVER_CLK_PERIOD);
        end

        serial_data_in_tb = 1'b1;
        #(prescale_tb * RECEIVER_CLK_PERIOD);

        $display("time = %0t", $time);
        $display("Transmitted data = %2h", transmitted_byte);
        $display("Received data = %2h", parallel_data_tb);

        // Wait 1 cycle for the DATA_VALID state
        #(1 * RECEIVER_CLK_PERIOD)

        if (parallel_data_tb == transmitted_byte && data_valid_tb == 1'b1) begin
            $display("Test case (4) passed.");
            $fdisplay(file, "Test case (4) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $display("Test case (4) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (4) failed.");
            $fdisplay(file, "parallel data = %b, data_valid = %b", parallel_data_tb, data_valid_tb);
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        serial_data_in_tb = 1'b1;
        #(4 * RECEIVER_CLK_PERIOD);

        $display("--------------------- Test case (5) ---------------------");
        parity_enable_tb = 1'b1;
        transmitted_byte = 'h57;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, prescale = %6b", 
                  parity_enable_tb, prescale_tb);
        
        serial_data_in_tb = 1'b0;
        #(RECEIVER_CLK_PERIOD);
        
        serial_data_in_tb = 1'b1;
        @(posedge frame_error_tb)
        #(2 * RECEIVER_CLK_PERIOD);
        
        if (~frame_error_tb) begin
            $display("Test case (5) passed.");
            $fdisplay(file, "Test case (5) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $display("Test case (5) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (5) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        serial_data_in_tb = 1'b1;
        #(4 * RECEIVER_CLK_PERIOD);

        $display("--------------------- Test case (6) ---------------------");
        parity_enable_tb = 1'b1;
        parity_type_tb = 1'b1;
        transmitted_byte = 'h57;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, prescale = %6b", 
                  parity_enable_tb, prescale_tb);
        
        serial_data_in_tb = 1'b0;
        #(prescale_tb * RECEIVER_CLK_PERIOD);

        for (i = 0; i <= DATA_WIDTH - 1; i = i + 1) begin
            serial_data_in_tb = transmitted_byte[i];
            #(prescale_tb * RECEIVER_CLK_PERIOD);
        end
        
        serial_data_in_tb = ^transmitted_byte;
        #(prescale_tb * RECEIVER_CLK_PERIOD);
        
        serial_data_in_tb = 1'b1;
        @(posedge parity_error_tb)
        #(2 * RECEIVER_CLK_PERIOD)


        if (~parity_error_tb) begin
            $display("Test case (6) passed.");
            $fdisplay(file, "Test case (6) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $display("Test case (6) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (6) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        serial_data_in_tb = 1'b1;
        #(4 * RECEIVER_CLK_PERIOD);

        $display("--------------------- Test case (7) ---------------------");
        parity_enable_tb = 1'b0;
        parity_type_tb = 1'b1;
        transmitted_byte = 'h88;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, prescale = %6b", 
                  parity_enable_tb, prescale_tb);
        
        serial_data_in_tb = 1'b0;
        #(prescale_tb * RECEIVER_CLK_PERIOD);

        for (i = 0; i <= DATA_WIDTH - 1; i = i + 1) begin
            serial_data_in_tb = transmitted_byte[i];
            #(prescale_tb * RECEIVER_CLK_PERIOD);
        end
        
        serial_data_in_tb = 1'b0;
        @(posedge frame_error_tb)
        #(2 * RECEIVER_CLK_PERIOD)


        if (~frame_error_tb) begin
            $display("Test case (7) passed.");
            $fdisplay(file, "Test case (7) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $display("Test case (7) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (7) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        $display("--------------------- Test case (8) ---------------------");
        parity_enable_tb = 1'b1;
        transmitted_byte = 'h57;
        $display("time = %0t", $time);
        $display("Configuration signals: parity_enable = %1b, prescale = %6b", 
                  parity_enable_tb, prescale_tb);
        
        serial_data_in_tb = 1'b0;
        #(RECEIVER_CLK_PERIOD);
        
        serial_data_in_tb = 1'b1;
        @(posedge frame_error_tb)
        #(2 * RECEIVER_CLK_PERIOD);
        
        if (~frame_error_tb) begin
            $display("Test case (8) passed.");
            $fdisplay(file, "Test case (8) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $display("Test case (8) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (8) failed.");
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
        prescale_tb = 6'b00_1000;
        serial_data_in_tb = 1'b0;
    end
    endtask

    // Reset the system in one clock cycle
    task reset();
    begin
        #RECEIVER_CLK_PERIOD
        reset_tb = 1'b0;
        #RECEIVER_CLK_PERIOD
        reset_tb = 1'b1;
    end
    endtask

    // Clock generator
    always #(RECEIVER_CLK_PERIOD / 2.0) clk_tb = ~clk_tb;


    // UART receiever top module instantiation
    UART_receiver #(
        .DATA_WIDTH(DATA_WIDTH)
    ) U_UART_receiver (
        .clk(clk_tb),
        .reset(reset_tb),
        .parity_type(parity_type_tb),
        .parity_enable(parity_enable_tb),
        .prescale(prescale_tb),
        .serial_data_in(serial_data_in_tb),

        .data_valid(data_valid_tb),
        .parallel_data(parallel_data_tb),
        .parity_error(parity_error_tb),
        .frame_error(frame_error_tb)
    );

endmodule