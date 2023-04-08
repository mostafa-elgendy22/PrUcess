/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:              
* reset:            
* parity_type:       
* enable:            
* sampled_bit:       
* parallel_data:       
* 
* ----------------------------- Outputs -----------------------------
* parity_bit_error: 
*/

module parity_bit_checker #(
    parameter DATA_WIDTH = 8
) 
(
    input clk,
    input reset,
    input parity_type,
    input enable,
    input sampled_bit,
    input [DATA_WIDTH - 1:0] parallel_data,
    
    output reg parity_bit_error 
);

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            parity_bit_error <= 1'b0;
        end
        else if (enable) begin
            case (parity_type)
                1'b1: begin
                    parity_bit_error <= (~^parallel_data) ^ sampled_bit;
                end

                1'b0: begin
                    parity_bit_error <= (^parallel_data) ^ sampled_bit;
                end
            endcase
        end
        else begin
            parity_bit_error <= 1'b0;
        end
    end

endmodule