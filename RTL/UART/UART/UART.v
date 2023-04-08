/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* transmitter_clk:                 Generated clock produced from the clock divider whose 
*                                  source clock is UART clock.
* receiver_clk:                    UART clock.
* reset:                           Global active low asynchronous reset after synchronization.
* parity_type:                     A signal to indicate the parity type (1 for odd, 0 for even).
* parity_enable:                   A signal to enable the transmission of the parity bit in the frame.
* prescale:                        The ratio between the frequency of the receiver and the frequecy
*                                  of the transmitter (The avaialable prescale values are: 8, 16, 32).
* transmitter_parallel_data_valid: A signal that indicates that there exist data to be transmitted
*                                  from the UART transmitter.
* transmitter_parallel_data:       The data to be transmitted by the UART transmitter.
* serial_data_receiver:            The data which is received serially by the UART receiver. 
* 
* ----------------------------- Outputs -----------------------------
* serial_data_transmitter:         The output of the UART transmitter (It is also the output of the
*                                  mux that select between start, serial data, parity, or stop bits
*                                  according to the state of the transmission).
* transmitter_busy:                A signal that indicates that the UART transmitter is currently
*                                  in operation and it can't transmit new data.
* receiver_parallel_data_valid:    A signal to indicate that the received data by the UART
*                                  receiver was free of errors.
* receiver_parallel_data:          The data which is received serially bit by bit.
* parity_error_receiver:           A signal to indicate that there is parity mismatch between the received parity bit
*                                  and the calculated parity bit.
* frame_error_receiver:            A signal to indicate that the start bit or the stop bit was incorrect.
*/

`include "../UART_transmitter/UART_transmitter.v"
`include "../UART_receiver/UART_receiver.v"

module UART #(
    parameter DATA_WIDTH = 8
)
(
    input transmitter_clk,
    input receiver_clk,
    input reset,
    input parity_type,
    input parity_enable,
    input [5:0] prescale,
    input transmitter_parallel_data_valid,
    input [DATA_WIDTH - 1:0] transmitter_parallel_data,
    input serial_data_receiver,
    
    output serial_data_transmitter,
    output transmitter_busy,
    output receiver_parallel_data_valid,
    output [DATA_WIDTH - 1:0] receiver_parallel_data,
    output parity_error_receiver,
    output frame_error_receiver
);

    UART_transmitter #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_UART_transmitter(
        .clk(transmitter_clk),
        .reset(reset),
        .parity_type(parity_type),
        .parity_enable(parity_enable),
        .data_valid(transmitter_parallel_data_valid),
        .parallel_data(transmitter_parallel_data),

        .serial_data_out(serial_data_transmitter),
        .busy(transmitter_busy)

    );

    UART_receiver #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_UART_receiver(
        .clk(receiver_clk),
        .reset(reset),
        .parity_type(parity_type),
        .parity_enable(parity_enable),
        .prescale(prescale),
        .serial_data_in(serial_data_receiver),

        .data_valid(receiver_parallel_data_valid),
        .parallel_data(receiver_parallel_data),
        .parity_error(parity_error_receiver),
        .frame_error(frame_error_receiver)
    );

endmodule