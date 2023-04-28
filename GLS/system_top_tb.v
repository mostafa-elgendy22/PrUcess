// `include "../../physical_design/physical_design_output/netlist/system_top_netlist.v"
`timescale 1ns/1ps

module system_top_tb;
    parameter DATA_WIDTH = 8;
    parameter REGISTER_FILE_DEPTH = 16;
    parameter SYNCHRONIZER_STAGE_COUNT = 2;

    localparam PRESCALE = 8;

	localparam TEST_CASES_DEPTH = 4;

	localparam TEST_CASES_WIDTH = 11;

    // Reference clock frequency = 40 MHz, clock period = 25 ns
    parameter REFERENCE_CLK_PERIOD = 25;

    // UART clock frequency = 115.2 KHz * 32 = 3686.4, clock period = 271 ns
    parameter UART_CLK_PERIOD = 271;

    // Input signals' declaration
    reg reference_clk_tb;
    reg UART_clk_tb;
    reg reset_tb;
    reg serial_data_in_tb;

    // Output signals' declaration
    wire serial_data_out_tb;
    wire parity_error_tb;
    wire frame_error_tb;

    // UART transmitter busy signal (internal signal)
    wire UART_transmitter_busy_tb;

    // Output file
    integer output_file;

    reg [TEST_CASES_WIDTH - 1:0] test_cases [0:TEST_CASES_DEPTH - 1];
    reg [DATA_WIDTH + 2:0] out;
    integer i;
    integer current_test_case;
    integer internal_index;

    initial begin
        // $sdf_annotate("../../physical_design/physical_design_output/system_top.sdf", U_system_top);
        $timeformat(-9, 2, " ns", 20);
        output_file = $fopen("output_files/system_outputs_verilog.txt", "w");
        $readmemb("test_cases.txt", test_cases);
        initialize();
        reset();
        
        #(PRESCALE * UART_CLK_PERIOD);

        for (current_test_case = 0; current_test_case < TEST_CASES_DEPTH; current_test_case = current_test_case + 1) begin
            case (test_cases[current_test_case][DATA_WIDTH:1])
                'hAA: begin
                    for (internal_index = current_test_case; internal_index < current_test_case + 3; internal_index = internal_index + 1) begin
                        for (i = 0; i < TEST_CASES_WIDTH; i = i + 1) begin
                            serial_data_in_tb <= test_cases[internal_index][i];
                            #(PRESCALE * UART_CLK_PERIOD);
                        end
                        #(3 * UART_CLK_PERIOD);
                    end
                    $display("Register file write");
                    current_test_case = current_test_case + 2;
                end

                'hBB: begin
                    for (internal_index = current_test_case; internal_index < current_test_case + 2; internal_index = internal_index + 1) begin
                        for (i = 0; i < TEST_CASES_WIDTH; i = i + 1) begin
                            serial_data_in_tb <= test_cases[internal_index][i];
                            #(PRESCALE * UART_CLK_PERIOD);
                        end
                        #(3 * UART_CLK_PERIOD);
                    end
                    
                    @(posedge UART_transmitter_busy_tb);
                    for (i = 0; i < TEST_CASES_WIDTH; i = i + 1) begin
                        #(PRESCALE * UART_CLK_PERIOD);
                        out[i] <= serial_data_out_tb;
                    end
                    $fdisplay(output_file, "%b", out[DATA_WIDTH:1]);
                    $display("Register file read");
                    current_test_case = current_test_case + 1;
                end

                'hCC: begin
                    for (internal_index = current_test_case; internal_index < current_test_case + 4; internal_index = internal_index + 1) begin
                        for (i = 0; i < TEST_CASES_WIDTH; i = i + 1) begin
                            serial_data_in_tb <= test_cases[internal_index][i];
                            #(PRESCALE * UART_CLK_PERIOD);
                        end
                        #(3 * UART_CLK_PERIOD);
                    end
                    
                    @(posedge UART_transmitter_busy_tb);
                    for (i = 0; i < TEST_CASES_WIDTH; i = i + 1) begin
                        #(PRESCALE * UART_CLK_PERIOD);
                        out[i] <= serial_data_out_tb;
                    end
                    $fdisplay(output_file, "%b", out[DATA_WIDTH:1]);
                    
                    @(negedge UART_transmitter_busy_tb)
                    @(posedge UART_transmitter_busy_tb)
                    for (i = 0; i < TEST_CASES_WIDTH; i = i + 1) begin
                        #(PRESCALE * UART_CLK_PERIOD);
                        out[i] <= serial_data_out_tb;
                    end
                    $fdisplay(output_file, "%b", out[DATA_WIDTH:1]);
                    $display("ALU with operands");
                    current_test_case = current_test_case + 3;
                end

                'hDD: begin
                    for (internal_index = current_test_case; internal_index < current_test_case + 2; internal_index = internal_index + 1) begin
                        for (i = 0; i < TEST_CASES_WIDTH; i = i + 1) begin
                            serial_data_in_tb <= test_cases[internal_index][i];
                            #(PRESCALE * UART_CLK_PERIOD);
                        end
                        #(3 * UART_CLK_PERIOD);
                    end
                    
                    @(posedge UART_transmitter_busy_tb);
                    for (i = 0; i < TEST_CASES_WIDTH; i = i + 1) begin
                        #(PRESCALE * UART_CLK_PERIOD);
                        out[i] <= serial_data_out_tb;
                    end
                    $fdisplay(output_file, "%b", out[DATA_WIDTH:1]);
                    
                    @(negedge UART_transmitter_busy_tb)
                    @(posedge UART_transmitter_busy_tb)
                    for (i = 0; i < TEST_CASES_WIDTH; i = i + 1) begin
                        #(PRESCALE * UART_CLK_PERIOD);
                        out[i] <= serial_data_out_tb;
                    end
                    $fdisplay(output_file, "%b", out[DATA_WIDTH:1]);
                    $display("ALU without operands");
                    current_test_case = current_test_case + 1;
                end

            endcase
        end
        $stop;
    end
 
    // Initialize all the input signals
    task initialize();
    begin
        reference_clk_tb = 1'b0;
        UART_clk_tb = 1'b0;
        reset_tb = 1'b1;
        serial_data_in_tb = 1'b1;
    end
    endtask

    // Reset the system in one clock cycle
    task reset();
    begin
        #UART_CLK_PERIOD
        reset_tb = 1'b0;
        #UART_CLK_PERIOD
        reset_tb = 1'b1;
    end
    endtask

    // Reference clock generator
    always #(REFERENCE_CLK_PERIOD / 2.0) reference_clk_tb = ~reference_clk_tb;

    // UART clock generator
    always #(UART_CLK_PERIOD / 2.0) UART_clk_tb = ~UART_clk_tb;

    // The UART transmitter busy signal
    assign UART_transmitter_busy_tb = U_system_top.U_UART.transmitter_busy;

    // DUT instantiation
    system_top U_system_top(
        .reference_clk(reference_clk_tb),
        .UART_clk(UART_clk_tb),
        .reset(reset_tb),
        .serial_data_in(serial_data_in_tb),

        .serial_data_out(serial_data_out_tb),
        .parity_error(parity_error_tb),
        .frame_error(frame_error_tb)
    );
endmodule