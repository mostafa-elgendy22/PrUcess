set CG_cell {module clock_gating_cell (
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

endmodule}

set ICG_cell {module clock_gating_cell (
    input clk,
    input clk_enable,

    output gated_clock
);

    TLATNCAX4M U_ICG_cell (
        .E(clk_enable),
        .CK(clk),
        .ECK(gated_clock)
    );

endmodule}

set clock_gating_cell_file_handle [open "clock_gating_cell.v" w+]

if {[lindex $argv 0] == "-p"} {
    puts $clock_gating_cell_file_handle $ICG_cell

} elseif {[lindex $argv 0] == "-r"} {
    puts $clock_gating_cell_file_handle $CG_cell
}

close $clock_gating_cell_file_handle