/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:              UART clock.
* reset:            Global active low asynchronous reset after synchronization.
* parity_type:      A signal to indicate the parity type (1 for odd, 0 for even).
* enable:           A signal to enable the operation of the parity bit checker.
* sampled_bit:      The sampled bit from the data sampler. It is always the parity bit
*                   for this module because it is only enabled when the parity bit is received.
* parallel_data:    The data which is received serially bit by bit.
* 
* ----------------------------- Outputs -----------------------------
* parity_bit_error: A signal to indicate that there is parity mismatch between the received parity bit
*                   and the calculated parity bit.
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