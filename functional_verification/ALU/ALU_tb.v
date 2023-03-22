`include "../ALU.v"
`timescale 1ns/1ns

module ALU_tb ();

    // Input signals' declaration
    reg [15:0] A_tb, B_tb;
    reg clk_tb;
    reg[3:0] ALU_FUN_tb;

    // Output signals' declaration
    wire Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb;
    wire [15:0] ALU_OUT_tb;


    initial 
    begin
        $dumpfile("ALU.vcd");
        $dumpvars;

        // Initial values
        clk_tb = 1'b0;
        A_tb = 16'd0;
        B_tb = 16'd0;
        ALU_FUN_tb = 4'b0000;

        // Test case (1)
        #3
        A_tb = 16'd5;
        B_tb = 16'd10;
        ALU_FUN_tb = 4'b0000;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd15 && Arith_flag_tb == 1'b1 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 1 is successful!");
            end
        else
            begin
                $display("Test case 1 has failed!");
            end

        // Test case (2)
        #6
        A_tb = 16'd16;
        B_tb = 16'd12;
        ALU_FUN_tb = 4'b0001;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd4 && Arith_flag_tb == 1'b1 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 2 is successful!");
            end
        else
            begin
                $display("Test case 2 has failed!");
            end

        // Test case (3)
        #6
        A_tb = 16'd4;
        B_tb = 16'd8;
        ALU_FUN_tb = 4'b0010;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd32 && Arith_flag_tb == 1'b1 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 3 is successful!");
            end
        else
            begin
                $display("Test case 3 has failed!");
            end

        // Test case (4)
        #6
        A_tb = 16'd12;
        B_tb = 16'd2;
        ALU_FUN_tb = 4'b0011;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd6 && Arith_flag_tb == 1'b1 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 4 is successful!");
            end
        else
            begin
                $display("Test case 4 has failed!");
            end

        // Test case (5)
        #6
        A_tb = 16'd15;
        B_tb = 16'd7;
        ALU_FUN_tb = 4'b0100;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd7 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b1 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 5 is successful!");
            end
        else
            begin
                $display("Test case 5 has failed!");
            end

        // Test case (6)
        #6
        A_tb = 16'd15;
        B_tb = 16'd7;
        ALU_FUN_tb = 4'b0101;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd15 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b1 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 6 is successful!");
            end
        else
            begin
                $display("Test case 6 has failed!");
            end


        // Test case (7)
        #6
        A_tb = 16'd15;
        B_tb = 16'd7;
        ALU_FUN_tb = 4'b0110;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'hFFF8 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b1 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 7 is successful!");
            end
        else
            begin
                $display("Test case 7 has failed!");
            end

        // Test case (8)
        #6
        A_tb = 16'd0;
        B_tb = 16'd0;
        ALU_FUN_tb = 4'b0111;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
    
        if (ALU_OUT_tb == 16'hFFFF && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b1 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 8 is successful!");
            end
        else
            begin
                $display("Test case 8 has failed!");
            end


        // Test case (9)
        #6
        A_tb = 16'd0;
        B_tb = 16'd0;
        ALU_FUN_tb = 4'b1000;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd0 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b1 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 9 is successful!");
            end
        else
            begin
                $display("Test case 9 has failed!");
            end

        // Test case (10)
        #6
        A_tb = 16'd0;
        B_tb = 16'd0;
        ALU_FUN_tb = 4'b1001;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'hFFFF && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b1 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 10 is successful!");
            end
        else
            begin
                $display("Test case 10 has failed!");
            end


        // Test case (11)
        #6
        A_tb = 16'd5;
        B_tb = 16'd5;
        ALU_FUN_tb = 4'b1010;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd1 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b1 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 11 is successful!");
            end
        else
            begin
                $display("Test case 11 has failed!");
            end

        // Test case (12)
        #6
        A_tb = 16'd5;
        B_tb = 16'd8;
        ALU_FUN_tb = 4'b1011;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd0 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b1 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 12 is successful!");
            end
        else
            begin
                $display("Test case 12 has failed!");
            end


        // Test case (13)
        #6
        A_tb = 16'd5;
        B_tb = 16'd8;
        ALU_FUN_tb = 4'b1100;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd3 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b1 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 13 is successful!");
            end
        else
            begin
                $display("Test case 13 has failed!");
            end

        
        // Test case (14)
        #6
        A_tb = 16'd7;
        ALU_FUN_tb = 4'b1101;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd3 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b1)
            begin
                $display("Test case 14 is successful!");
            end
        else
            begin
                $display("Test case 14 has failed!");
            end


        // Test case (15)
        #6
        A_tb = 16'd7;
        ALU_FUN_tb = 4'b1110;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd14 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b1)
            begin
                $display("Test case 15 is successful!");
            end
        else
            begin
                $display("Test case 15 has failed!");
            end

        // Test case (16)
        #6
        A_tb = 16'd7;
        ALU_FUN_tb = 4'b1111;

        #4
        $display("A = %0d, B = %0d, Function = %4b, Arith_Logic_CMP_Shift = %4b, ALU_OUT = %0d", A_tb, B_tb, ALU_FUN_tb, {Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb}, ALU_OUT_tb);
        
        if (ALU_OUT_tb == 16'd0 && Arith_flag_tb == 1'b0 && Logic_flag_tb == 1'b0 && CMP_flag_tb == 1'b0 && Shift_flag_tb == 1'b0)
            begin
                $display("Test case 16 is successful!");
            end
        else
            begin
                $display("Test case 16 has failed!");
            end

        #20
        $stop;

end

// Create the clock source
always #5 clk_tb = !clk_tb;


// Instantiate the ALU
ALU DUT (
    .clk(clk_tb),
    .A(A_tb),
    .B(B_tb),
    .ALU_Function(ALU_FUN_tb),
    .Arith_flag(Arith_flag_tb),
    .Logic_flag(Logic_flag_tb),
    .CMP_flag(CMP_flag_tb),
    .Shift_flag(Shift_flag_tb),
    .ALU_OUT(ALU_OUT_tb)
);
endmodule