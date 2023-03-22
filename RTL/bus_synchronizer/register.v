module register #(
    parameter BUS_WIDTH = 1
)
(
    input clk,
    input reset,
    input [BUS_WIDTH - 1:0] D,

    output reg [BUS_WIDTH - 1:0] Q
);

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            Q <= 'b0;
        end
        else begin
            Q <= D;
        end
    end

endmodule