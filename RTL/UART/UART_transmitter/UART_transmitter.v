/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:             Generated clock produced from the clock divider whose source clock is
*                  UART clock.
* reset:           Global active low asynchronous reset after synchronization.
* parity_type:     Signal to indicate the parity type (1 for odd, 0 for even).
* parity_enable:   Signal to enable the transmission of the parity bit in the frame.
* data_valid:      Signal that indicates that there exist data to be transmitted.
* parallel_data:   The data to be transmitted by the UART transmitter, and its size is 1-byte.
* 
* ----------------------------- Outputs -----------------------------
* serial_data_out: The output of the transmitter (It is also the output of the mux that selects
*                  between start, serial data, parity, or stop bits according to the state
*                  of the transmission).
* busy:            A signal that indicates that the transmitter is currently in operation
*                  and it can't transmit a new byte.
*/

`include "UART_transmitter_FSM.v"
`include "serializer.v"
`include "parity_calculator.v"
`include "output_multiplexer.v"

module UART_transmitter #(
    parameter DATA_WIDTH = 8
)
(
    input clk,
    input reset,
    input parity_type,
    input parity_enable,
    input data_valid,
    input [DATA_WIDTH - 1:0] parallel_data,

    output serial_data_out,
    output busy

);

    // Bit select values of the output mux
    localparam [1:0] START_BIT_SELECT = 2'b00;
    localparam [1:0] STOP_BIT_SELECT = 2'b01;
    localparam [1:0] SERIAL_DATA_BIT_SELECT = 2'b10;
    localparam [1:0] PARITY_BIT_SELECT = 2'b11;

    // Internal signals' decalaration
    wire serial_enable;
    wire [$clog2(DATA_WIDTH) - 1:0] serial_data_index;
    wire [1:0] bit_select;
    wire serial_data;
    wire parity_bit;

    UART_transmitter_FSM #(
        .DATA_WIDTH(DATA_WIDTH),
        .START_BIT_SELECT(START_BIT_SELECT),
        .STOP_BIT_SELECT(STOP_BIT_SELECT),
        .SERIAL_DATA_BIT_SELECT(SERIAL_DATA_BIT_SELECT),
        .PARITY_BIT_SELECT(PARITY_BIT_SELECT)
    )  
    U_UART_transmitter_FSM (
        .clk(clk),
        .reset(reset),
        .data_valid(data_valid),
        .parity_enable(parity_enable),
        .serial_enable(serial_enable),
        .bit_select(bit_select),
        .serial_data_index(serial_data_index),
        .busy(busy)
    );


    serializer #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_serializer (
        .clk(clk),
        .reset(reset),
        .parallel_data(parallel_data),
        .serial_enable(serial_enable),
        .serial_data_index(serial_data_index),
        .serial_data(serial_data)
    );


    parity_calculator #(
        .DATA_WIDTH(DATA_WIDTH)
    ) 
    U_parity_calculator (
        .clk(clk),
        .reset(reset),
        .parity_type(parity_type),
        .parity_enable(parity_enable),
        .data_valid(data_valid),
        .parallel_data(parallel_data),
        .parity_bit(parity_bit)
    );


    output_multiplexer # (
        .START_BIT_SELECT(START_BIT_SELECT),
        .STOP_BIT_SELECT(STOP_BIT_SELECT),
        .SERIAL_DATA_BIT_SELECT(SERIAL_DATA_BIT_SELECT),
        .PARITY_BIT_SELECT(PARITY_BIT_SELECT)
    ) U_output_multiplexer (
        .bit_select(bit_select),
        .serial_data(serial_data),
        .parity_bit(parity_bit),
        .mux_out(serial_data_out)
    );

endmodule