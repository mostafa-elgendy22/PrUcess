/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:                The clock of the destination domain.
* reset:              Unsynchronized global active low reset.
* 
* ----------------------------- Outputs -----------------------------
* reset_synchronized: The reset signal after synchronization to the destination domain.
*/

module reset_synchronizer #(
    parameter STAGE_COUNT = 2
)
(
    input clk,
    input reset,

    output reset_synchronized
);

    reg [0:STAGE_COUNT - 1] Q;
    integer i;

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            Q <= 'b0;
        end
        else begin
            Q[0] <= 1'b1;
            for (i = 1; i < STAGE_COUNT; i = i + 1) begin
                Q[i] <= Q[i - 1];
            end
        end
    end

    assign reset_synchronized = Q[STAGE_COUNT - 1];

endmodule