`include "../../RTL/register_file/register_file.v"
`timescale 1ns/1ps

module register_file_tb ();

    parameter DATA_WIDTH = 8;
    parameter REGISTER_FILE_DEPTH = 16;

    // Input signals' declaration
    reg clk_tb;
    reg reset_tb;
    reg [$clog2(REGISTER_FILE_DEPTH) - 1:0] address_tb;
    reg write_enable_tb;
    reg read_enable_tb;
    reg [DATA_WIDTH - 1:0] write_data_tb;

    // Output signals' declaration
    wire [DATA_WIDTH - 1:0] read_data_tb;
    wire read_data_valid_tb;
    wire [DATA_WIDTH - 1:0] register0_tb;
    wire [DATA_WIDTH - 1:0] register1_tb;
    wire [DATA_WIDTH - 1:0] register2_tb;
    wire [DATA_WIDTH - 1:0] register3_tb;

    integer i;
    integer file;
    integer passed_test_cases;
    integer total_test_cases;

    // Clock frequency = 200 MHz, clock period = 5 ns
    localparam CLK_PERIOD = 5;



    initial begin
        $timeformat(-9, 2, " ns", 20);
        file = $fopen("output.txt", "w");
        passed_test_cases = 0;
        total_test_cases = 0;

        initialize();
        reset();

        $display("--------------------- Test case (1) ---------------------");
        address_tb = 'b1110;
        write_enable_tb = 1'b1;
        write_data_tb = 'hF4;
        $display("time = %0t", $time);
        
        #CLK_PERIOD
        
        write_enable_tb = 1'b0;
        read_enable_tb = 1'b1;

        #CLK_PERIOD

        if (read_data_valid_tb == 1'b1 && read_data_tb == write_data_tb) begin
            $display("Test case (1) passed.");
            $fdisplay(file, "Test case (1) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $display("Test case (1) failed.");
            $fdisplay(file, "----------------------------------------------------------------");
            $fdisplay(file, "Test case (1) failed.");
            $fdisplay(file, "read_data = %8b", read_data_tb);
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
        address_tb = 'b0;
        write_enable_tb = 'b0;
        read_enable_tb = 'b0;
        write_data_tb = 'b0;
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


    // UART receiever top module instantiation
    register_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .REGISTER_FILE_DEPTH(REGISTER_FILE_DEPTH)
    ) U_register_file (
        .clk(clk_tb),
        .reset(reset_tb),
        .address(address_tb),
        .write_enable(write_enable_tb),
        .read_enable(read_enable_tb),
        .write_data(write_data_tb),
        
        .read_data(read_data_tb),
        .read_data_valid(read_data_valid_tb),
        .register0(register0_tb),
        .register1(register1_tb),
        .register2(register2_tb),
        .register3(register3_tb)
    );

endmodule