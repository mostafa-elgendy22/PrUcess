`include "../../RTL/data_synchronizer/data_synchronizer.v"

module data_synchronizer_tb ();
    parameter STAGE_COUNT = 2;
    parameter BUS_WIDTH = 4;

    
    localparam SOURCE_CLK_PERIOD = 50;
    localparam DESTINATION_CLK_PERIOD = 12;


    // Read the input data codes from the external input file
    reg [BUS_WIDTH - 1:0] input_data [0:2 ** BUS_WIDTH - 1];

    // Input signals' declaration
    reg destination_clk_tb;
    reg reset_tb;
    reg asynchronous_data_valid_tb;
    reg [BUS_WIDTH - 1:0] asynchronous_data_tb;


    // Output signals' declaration
    wire [BUS_WIDTH - 1:0] synchronous_data_tb;
    wire synchronous_data_valid_tb;
    wire Q_pulse_generator_tb;

    integer i, j, k;
    integer passed_test_cases;
    integer total_test_cases;

    // Output file
    integer file;


    initial 
    begin
        $timeformat(-9, 2, " ns", 20);
        $readmemb("inputs.txt", input_data);        
        file = $fopen("output.txt", "w");
        total_test_cases = 2 ** BUS_WIDTH;
        passed_test_cases = 0;
        initialize();
        reset();
        

        for (i = 0; i < 2 ** BUS_WIDTH; i = i + 1) begin
            asynchronous_data_tb = input_data[i];
            asynchronous_data_valid_tb = 1'b1;

            @(posedge synchronous_data_valid_tb);
            if (synchronous_data_tb == asynchronous_data_tb) begin
                $fdisplay(file, "Test case (%0d) passed.", i + 1);
                passed_test_cases = passed_test_cases + 1;
            end
            else begin
                $fdisplay(file, "Test case (%0d) failed.", i + 1);
            end
            asynchronous_data_valid_tb = 1'b0;
            #SOURCE_CLK_PERIOD;
        end
        $fdisplay(file, "Total: %0d/%0d.", passed_test_cases, total_test_cases);
        $stop;
    end


    // Initialize all the input signals
    task initialize();
    begin
        destination_clk_tb = 1'b0;
        reset_tb = 1'b1;
        asynchronous_data_valid_tb = 1'b0;
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
    always #(DESTINATION_CLK_PERIOD / 2.0) destination_clk_tb = ~destination_clk_tb;



    // DUT instantiation
    data_synchronizer #(
        .STAGE_COUNT(STAGE_COUNT),
        .BUS_WIDTH(BUS_WIDTH)
    )
    U_data_synchronizer (
        .clk(destination_clk_tb),
        .reset(reset_tb),
        .asynchronous_data_valid(asynchronous_data_valid_tb),
        .asynchronous_data(asynchronous_data_tb),

        .Q_pulse_generator(Q_pulse_generator_tb),
        .synchronous_data(synchronous_data_tb),
        .synchronous_data_valid(synchronous_data_valid_tb)
    );
endmodule