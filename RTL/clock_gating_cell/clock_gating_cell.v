/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:        The source clock to be gated (reference clock).
* clk_enable: An enable signal for the clock gating.
* 
* ----------------------------- Outputs -----------------------------
* gated_clk:  The output gated clock (ALU clock).
*/
module clock_gating_cell (
    input clk,
    input clk_enable,

    output gated_clock
);
    reg Q;

    // Active low latch
    always @(clk or clk_enable) begin
        if (~clk) begin
            Q <= clk_enable;
        end
    end

    assign gated_clock = clk & Q;

endmodule
