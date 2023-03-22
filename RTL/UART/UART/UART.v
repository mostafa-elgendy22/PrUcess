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

        .TX_out(serial_data_transmitter),
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
        .serial_data(serial_data_receiver),

        .data_valid(receiver_parallel_data_valid),
        .parallel_data(receiver_parallel_data),
        .parity_error(parity_error_receiver),
        .frame_error(frame_error_receiver)
    );

endmodule