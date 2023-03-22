/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:           Generated clock produced from the clock divider whose source clock is
*                UART clock.
* reset:         Global active low asynchronous reset after synchronization.
* parity_type:   Signal to indicate the parity type (1 for odd, 0 for even).
* parity_enable: Signal to enable the transmission of the parity bit in the frame.
* parallel_data: The data to be transmitted by the UART transmitter, and its size is 1-byte.
* 
* ----------------------------- Outputs -----------------------------
* parity_bit:    The parity bit of the parallel data to be transmitted.
*/

module parity_calculator # (
    parameter DATA_WIDTH = 8
)
(
    input clk,
    input reset,
    input parity_type,
    input parity_enable,
    input data_valid,
    input [DATA_WIDTH - 1:0] parallel_data,
    
    output reg parity_bit
);


    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            parity_bit <= 1'b0;
        end
        else if (parity_enable && data_valid) begin
            if (parity_type) begin
                // Odd parity
                parity_bit <= ~^parallel_data;
            end
            else begin
                // Even parity
                parity_bit <= ^parallel_data;
            end
        end
    end

endmodule