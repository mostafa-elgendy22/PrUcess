/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:           System's master clock.
* reset:         Global active low asynchronous reset.
* parity_type:   Signal to indicate the parity type (1 for odd, 0 for even).
* parity_enable: Signal to enable the transmission of the parity bit in the frame.
* prescale:      The ratio between the frequency of the receiver and the frequecy of the 
*                transmitter (The avaialable prescale values are: 8, 16, 32).
* serial_data:   The data which is received serially. 
* 
* ----------------------------- Outputs -----------------------------
* parallel_data: The data which was transmitted serially bit by bit.
* data_valid:    Signal to indicate that the transmission was free of errors.
* parity_error:  Signal to indicate that there is parity mismatch between the received parity bit
*                and the calculated parity bit.
* frame_error:   Signal to indicate that the stop bit was not correct (i.e. it was '0' instead of '1').
*/

`include "UART_receiver_FSM.v"
`include "data_sampler.v"
`include "deserializer.v"
`include "edge_counter.v"
`include "start_bit_checker.v"
`include "parity_bit_checker.v"
`include "stop_bit_checker.v"
`include "multiplexer_2x1.v"

module UART_receiver #(
    parameter DATA_WIDTH = 8
) 
(
    input clk,
    input reset,
    input parity_type,
    input parity_enable,
    input [5:0] prescale,
    input serial_data,

    // ---------------- DFT ports ---------------- 
    input scan_clk,
    input scan_reset,
    input test_mode,
    input SE,
    input SI,
    output SO,
    // --------------------------------------------

    output [DATA_WIDTH - 1:0] parallel_data,
    output data_valid,
    output parity_error,
    output frame_error
);
    // Internal signals' decalaration
    wire start_bit_error;
    wire [4:0] edge_count;
    wire edge_count_done;
    wire start_bit_check_enable;
    wire parity_bit_check_enable;
    wire stop_bit_check_enable;
    wire edge_counter_and_data_sampler_enable;
    wire deserializer_enable;
    wire [$clog2(DATA_WIDTH) - 1:0] data_index;
    wire sampled_bit;

    wire multiplexed_clk;
    wire multiplexed_reset;


    multiplexer_2x1 U_clock_multiplexer (
        .IN0(clk),
        .IN1(scan_clk),
        .select(test_mode),
        
        .OUT(multiplexed_clk)
    );

    multiplexer_2x1 U_reset_multiplexer (
        .IN0(reset),
        .IN1(scan_reset),
        .select(test_mode),
        
        .OUT(multiplexed_reset)
    );


    UART_receiver_FSM #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_UART_receiver_FSM (
        .clk(multiplexed_clk),
        .reset(multiplexed_reset),
        .parity_enable(parity_enable),
        .serial_data(serial_data),
        .prescale(prescale),
        .start_bit_error(start_bit_error),
        .parity_bit_error(parity_error),
        .stop_bit_error(frame_error),
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
        .clk(multiplexed_clk),
        .reset(multiplexed_reset),
        .serial_data(serial_data),
        .prescale(prescale[5:1]),
        .enable(edge_counter_and_data_sampler_enable),
        .edge_count(edge_count),

        .sampled_bit(sampled_bit)
    );

    deserializer #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_deserializer (
        .clk(multiplexed_clk),
        .reset(multiplexed_reset),
        .enable(deserializer_enable),
        .data_index(data_index),
        .sampled_bit(sampled_bit),

        .parallel_data(parallel_data)
    );

    edge_counter U_edge_counter (
        .clk(multiplexed_clk),
        .reset(multiplexed_reset),
        .prescale(prescale),
        .enable(edge_counter_and_data_sampler_enable),

        .edge_count(edge_count),
        .edge_count_done(edge_count_done)
    );

    start_bit_checker U_start_bit_checker (
        .clk(multiplexed_clk),
        .reset(multiplexed_reset),
        .enable(start_bit_check_enable),
        .sampled_bit(sampled_bit),
        
        .start_bit_error(start_bit_error)
    );

    parity_bit_checker #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_parity_bit_checker (
        .clk(multiplexed_clk),
        .reset(multiplexed_reset),
        .parity_type(parity_type),
        .enable(parity_bit_check_enable),
        .sampled_bit(sampled_bit),
        .parallel_data(parallel_data),
        
        .parity_bit_error(parity_error) 
    );

    stop_bit_checker U_stop_bit_checker (
        .clk(multiplexed_clk),
        .reset(multiplexed_reset),
        .enable(stop_bit_check_enable),
        .sampled_bit(sampled_bit),
        
        .stop_bit_error(frame_error) 
    );


endmodule