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
