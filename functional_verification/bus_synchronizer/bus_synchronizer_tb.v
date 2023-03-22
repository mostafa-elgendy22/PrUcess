`include "../../RTL/bus_synchronizer/bus_synchronizer.v"
`timescale 1ns/1ns

module bus_synchronizer_tb ();

    parameter STAGE_COUNT = 2;
    parameter BUS_WIDTH = 4;

    // The two clock periods should satisfy the following condition to ensure that
    // any generated data by the source stays constant for at least two cycles of 
    // destination's clock so that the synchronizer will be able to produce the correct
    // output after two clock cycles (in case it enters metastability, 
    // but in simulation this doesn't happen).
    // The condition: (SOURCE_CLK_PERIOD / 2) >= DESTINATION_CLK_PERIOD
    // Which is equivalent to: SOURCE_CLK_PERIOD >= 2 * DESTINATION_CLK_PERIOD
    // In simulation, the condition should be: SOURCE_CLK_PERIOD >= DESTINATION_CLK_PERIOD
    localparam SOURCE_CLK_PERIOD = 30;
    localparam DESTINATION_CLK_PERIOD = 12;


    // Read the gray codes from the external input file
    reg [BUS_WIDTH - 1:0] gray_codes [0:2 ** BUS_WIDTH - 1];


    // Input signals' declaration
    reg clk_tb;
    reg reset_tb;
    reg [BUS_WIDTH - 1:0] asynchronous_data_tb;


    // Output signals' declaration
    wire [BUS_WIDTH - 1:0] synchronous_data_tb;

    integer i, j;

    // Output file
    integer file;


    initial 
    begin
        
        $timeformat(-9, 2, " ns", 20);
        $readmemb("gray_codes.txt", gray_codes);
        $monitor("time = %0t, synchronous_data = %b", $time, synchronous_data_tb);
        j = 0;
        initialize();
        reset();
        
        #(1.5 * DESTINATION_CLK_PERIOD);

        for (i = 1; i < 2 ** BUS_WIDTH; i = i + 1) begin
            asynchronous_data_tb <= gray_codes[i];
            // The data is generated from the source using its clock
            #SOURCE_CLK_PERIOD;
        end
    end

    always @(synchronous_data_tb) begin
        j = j + 1;
        if (j == 2 ** BUS_WIDTH) begin
            #(STAGE_COUNT * DESTINATION_CLK_PERIOD);
            $stop;
        end
    end

    // Initialize all the input signals
    task initialize();
    begin
        clk_tb = 1'b0;
        reset_tb = 1'b1;
        asynchronous_data_tb = 'b0;
    end
    endtask

    // Reset the system in one clock cycle
    task reset();
    begin
        #DESTINATION_CLK_PERIOD;
        reset_tb = 1'b0;
        #DESTINATION_CLK_PERIOD;
        reset_tb = 1'b1;
    end
    endtask

    // Destination clock generator
    always #(DESTINATION_CLK_PERIOD / 2.0) clk_tb = ~clk_tb;


    // DUT instantiation
    bus_synchronizer #(
        .STAGE_COUNT(STAGE_COUNT),
        .BUS_WIDTH(BUS_WIDTH)
    )
    U_bus_synchronizer (
        .clk(clk_tb),
        .reset(reset_tb),
        .asynchronous_data(asynchronous_data_tb),

        .synchronous_data(synchronous_data_tb)
    );

endmodule