/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:             UART clock.
* reset:           Global active low asynchronous reset after synchronization.
* enable:          A signal to enable the operation of the stop bit checker.
* sampled_bit:     The sampled bit from the data sampler. It is always the stop bit
*                  for this module because it is only enabled when the stop bit is received.
* 
* ----------------------------- Outputs -----------------------------
* stop_bit_error: A signal to indicate that the stop bit is incorrect (the sampled bit is 0).
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