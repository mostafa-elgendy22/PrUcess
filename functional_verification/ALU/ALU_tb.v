`include "../../RTL/ALU/ALU.v"
`timescale 1ns/1ns

module ALU_tb ();

    localparam DATA_WIDTH = 8;
    localparam CLK_PERIOD = 25;

    // Input signals' declaration
    reg clk_tb;
    reg reset_tb;
    reg enable_tb;
    reg [DATA_WIDTH - 1:0] A_tb, B_tb;
    reg[3:0] ALU_function_tb;

    // Output signals' declaration
    wire ALU_result_valid_tb;
    wire [2 * DATA_WIDTH - 1:0] ALU_result_tb;

    integer file;
    integer passed_test_cases, total_test_cases;

    initial begin
        $timeformat(-9, 2, " ns", 20);
        file = $fopen("output.txt", "w");
        passed_test_cases = 0;
        total_test_cases = 0;

        initialize();
        reset();

        $display("--------------------- Test case (1) ---------------------");
        enable_tb = 1'b1;
        A_tb = 8'h54;
        B_tb = 8'h2A;
        ALU_function_tb = 4'b0000;
        #CLK_PERIOD
        if (ALU_result_tb == A_tb + B_tb) begin
            $fdisplay(file, "Test case (1) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (1) failed.");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        $display("--------------------- Test case (2) ---------------------");
        A_tb = 8'h54;
        B_tb = 8'h2A;
        ALU_function_tb = 4'b0001;
        #CLK_PERIOD
        if (ALU_result_tb == A_tb - B_tb) begin
            $fdisplay(file, "Test case (2) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (2) failed.");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        $display("--------------------- Test case (3) ---------------------");
        A_tb = 8'h54;
        B_tb = 8'h2A;
        ALU_function_tb = 4'b0010;
        #CLK_PERIOD
        if (ALU_result_tb == A_tb * B_tb) begin
            $fdisplay(file, "Test case (3) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (3) failed.");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        $display("--------------------- Test case (4) ---------------------");
        A_tb = 8'h54;
        B_tb = 8'h2A;
        ALU_function_tb = 4'b0011;
        #CLK_PERIOD
        if (ALU_result_tb == A_tb / B_tb) begin
            $fdisplay(file, "Test case (4) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (4) failed.");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        $display("--------------------- Test case (5) ---------------------");
        A_tb = 8'h54;
        B_tb = 8'h2F;
        ALU_function_tb = 4'b0100;
        #CLK_PERIOD
        if (ALU_result_tb == {'b0, A_tb & B_tb}) begin
            $fdisplay(file, "Test case (5) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (5) failed.");
        end
        total_test_cases = total_test_cases + 1;
        $display("----------------------------------------------------------------");

        $display("--------------------- Test case (6) ---------------------");
        A_tb = 8'hF4;
        B_tb = 8'h2C;
        ALU_function_tb = 4'b0101;
        #CLK_PERIOD
        if (ALU_result_tb == {'b0, A_tb | B_tb}) begin
            $fdisplay(file, "Test case (6) passed.");
            passed_test_cases = passed_test_cases + 1;
        end
        else begin
            $fdisplay(file, "Test case (6) failed.");
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
        enable_tb = 1'b0;
        A_tb = 'b0;
        B_tb = 'b0;
        ALU_function_tb = 4'b0000;
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


    // Instantiate the ALU
    ALU # (
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_ALU (
        .clk(clk_tb),
        .reset(reset_tb),
        .A(A_tb),
        .B(B_tb),
        .ALU_function(ALU_function_tb),
        .enable(enable_tb),

        .ALU_result_valid(ALU_result_valid_tb),
        .ALU_result(ALU_result_tb)
    );
endmodule