/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:            UART clock.
* reset:          Global active low asynchronous reset after synchronization.
* parity_type:    A signal to indicate the parity type (1 for odd, 0 for even).
* parity_enable:  A signal to enable the transmission of the parity bit in the frame.
* prescale:       The ratio between the frequency of the receiver and the frequecy of the 
*                 transmitter (The avaialable prescale values are: 8, 16, 32).
* serial_data_in: The data which is received serially.
* 
* ----------------------------- Outputs -----------------------------
* data_valid:     A signal to indicate that the received data was free of errors.
* parallel_data:  The data which is received serially bit by bit.
* parity_error:   A signal to indicate that there is parity mismatch between the received parity bit
*                 and the calculated parity bit.
* frame_error:    A signal to indicate that the start bit or the stop bit was incorrect.
*/

`include "UART_receiver_FSM.v"
`include "data_sampler.v"
`include "deserializer.v"
`include "edge_counter.v"
`include "start_bit_checker.v"
`include "parity_bit_checker.v"
`include "stop_bit_checker.v"

module UART_receiver #(
    parameter DATA_WIDTH = 8
) 
(
    input clk,
    input reset,
    input parity_type,
    input parity_enable,
    input [5:0] prescale,
    input serial_data_in,

    output data_valid,
    output [DATA_WIDTH - 1:0] parallel_data,
    output parity_error,
    output frame_error
);
    // Internal signals' decalaration
    wire start_bit_error;
    wire stop_bit_error;
    wire [4:0] edge_count;
    wire edge_count_done;
    wire start_bit_check_enable;
    wire parity_bit_check_enable;
    wire stop_bit_check_enable;
    wire edge_counter_and_data_sampler_enable;
    wire deserializer_enable;
    wire [$clog2(DATA_WIDTH) - 1:0] data_index;
    wire sampled_bit;

    assign frame_error = start_bit_error | stop_bit_error;

    UART_receiver_FSM #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_UART_receiver_FSM (
        .clk(clk),
        .reset(reset),
        .parity_enable(parity_enable),
        .serial_data_in(serial_data_in),
        .prescale(prescale),
        .start_bit_error(start_bit_error),
        .parity_bit_error(parity_error),
        .stop_bit_error(stop_bit_error),
        .edge_count(edge_count),
        .edge_count_done(edge_count_done),

        .start_bit_check_enable(start_bit_check_enable),
        .parity_bit_check_enable(parity_bit_check_enable),
        .stop_bit_check_enable(stop_bit_check_enable),
        .edge_counter_and_data_sampler_enable(edge_counter_and_data_sampler_enable),
        .deserializer_enable(deserializer_enable),
        .data_index(data_index),
        .data_valid(data_valid)
    );

    data_sampler U_data_sampler (
        .clk(clk),
        .reset(reset),
        .serial_data_in(serial_data_in),
        .prescale(prescale[5:1]),
        .enable(edge_counter_and_data_sampler_enable),
        .edge_count(edge_count),

        .sampled_bit(sampled_bit)
    );

    deserializer #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_deserializer (
        .clk(clk),
        .reset(reset),
        .enable(deserializer_enable),
        .data_index(data_index),
        .sampled_bit(sampled_bit),

        .parallel_data(parallel_data)
    );

    edge_counter U_edge_counter (
        .clk(clk),
        .reset(reset),
        .prescale(prescale),
        .enable(edge_counter_and_data_sampler_enable),

        .edge_count(edge_count),
        .edge_count_done(edge_count_done)
    );

    start_bit_checker U_start_bit_checker (
        .clk(clk),
        .reset(reset),
        .enable(start_bit_check_enable),
        .sampled_bit(sampled_bit),
        
        .start_bit_error(start_bit_error)
    );

    parity_bit_checker #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_parity_bit_checker (
        .clk(clk),
        .reset(reset),
        .parity_type(parity_type),
        .enable(parity_bit_check_enable),
        .sampled_bit(sampled_bit),
        .parallel_data(parallel_data),
        
        .parity_bit_error(parity_error) 
    );

    stop_bit_checker U_stop_bit_checker (
        .clk(clk),
        .reset(reset),
        .enable(stop_bit_check_enable),
        .sampled_bit(sampled_bit),
        
        .stop_bit_error(stop_bit_error) 
    );


endmodule