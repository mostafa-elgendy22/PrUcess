/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:           UART clock.
* reset:         Global active low asynchronous reset after synchronization.
* enable:        A signal to enable the operation of the deserializer.
* data_index:    The index of the of bit to be received in the frame.
* sampled_bit:   The resulting sampled bit out of three samples taken at three different edges.
*                It is equal to the bit appearing the most times in the samples
*                (e.g. if samples = 101, sampled_bit = 1. if samples = 100, sampled_bit = 0).
* 
* ----------------------------- Outputs -----------------------------
* parallel_data: The data which is received serially bit by bit.
*/

module deserializer #(
    parameter DATA_WIDTH = 8
) 
(
    input clk,
    input reset,
    input enable,
    input [$clog2(DATA_WIDTH) - 1:0] data_index,
    input sampled_bit,

    output reg [DATA_WIDTH - 1:0] parallel_data
);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            parallel_data <= 8'b0;
        end
        else if (enable) begin
            parallel_data[data_index] <= sampled_bit;
        end
    end

endmodule