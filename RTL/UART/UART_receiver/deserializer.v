/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:           
* reset:         
* enable:         
* data_index:    
* sampled_bit:   
* 
* ----------------------------- Outputs -----------------------------
* parallel_data:  
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