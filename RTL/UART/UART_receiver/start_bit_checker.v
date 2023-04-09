/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:             UART clock.
* reset:           Global active low asynchronous reset after synchronization.
* enable:          A signal to enable the operation of the start bit checker.
* sampled_bit:     The sampled bit from the data sampler. It is always the start bit
*                  for this module because it is only enabled when the start bit is received.
* 
* ----------------------------- Outputs -----------------------------
* start_bit_error: A signal to indicate that the start bit is incorrect (the sampled bit is 1).
*/


module start_bit_checker (
    input clk,
    input reset,
    input enable,
    input sampled_bit,
    
    output reg start_bit_error 
);

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            start_bit_error <= 1'b0;
        end
        else if (enable) begin
            start_bit_error <= sampled_bit;
        end
        else begin
            start_bit_error <= 1'b0;
        end
    end

endmodule