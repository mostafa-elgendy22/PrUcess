/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:               The clock of the destination domain.
* reset:             Global active low asynchronous reset of the destination domain
*                    after synchronization.
* asynchronous_data: The data to be synchronized (it is sent from another asynchronous domain
*                    to the destination domain).
* 
* ----------------------------- Outputs -----------------------------
* synchronous_data:  The data after synchronization to the destination domain.
*/

`include "register.v"

module bus_synchronizer #(
    parameter STAGE_COUNT = 2,
    parameter BUS_WIDTH = 1
)
(
    input clk,
    input reset,
    input [BUS_WIDTH - 1:0] asynchronous_data,

    output [BUS_WIDTH - 1:0] synchronous_data
);

    genvar i;
    wire [BUS_WIDTH - 1:0] output_ports [0:STAGE_COUNT - 1];

    register #(
        .BUS_WIDTH(BUS_WIDTH)
    )
    U0_register (
        .clk(clk),
        .reset(reset),
        .D(asynchronous_data),

        .Q(output_ports[0])
    );


    generate
        for (i = 1; i < STAGE_COUNT; i = i + 1) begin: register_instance
            register #(
                .BUS_WIDTH(BUS_WIDTH)
            ) 
            U_register (
                .clk(clk),
                .reset(reset),
                .D(output_ports[i - 1]),

                .Q(output_ports[i])
            );
        end
    endgenerate

    assign synchronous_data = output_ports[STAGE_COUNT - 1];

endmodule