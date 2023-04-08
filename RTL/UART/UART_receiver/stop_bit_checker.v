/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:             
* reset:           
* enable:          
* sampled_bit:     
* 
* ----------------------------- Outputs -----------------------------
* stop_bit_error: 
*/

module stop_bit_checker (
    input clk,
    input reset,
    input enable,
    input sampled_bit,
    
    output reg stop_bit_error 
);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            stop_bit_error <= 1'b0;
        end
        else if (enable) begin
            stop_bit_error <= ~sampled_bit;
        end
        else begin
            stop_bit_error <= 1'b0;
        end
    end

endmodule