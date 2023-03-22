`include "UART_receiver_controller.v"
`include "UART_transmitter_controller.v"

module system_controller #(
    parameter DATA_WIDTH = 8,
    parameter REGISTER_FILE_DEPTH = 16
)
(
    input clk,
    input reset,

    // ALU output signals
    input ALU_result_valid,
    input [2 * DATA_WIDTH - 1:0] ALU_result,

    // Register file output signals
    input register_file_read_data_valid,
    input [DATA_WIDTH - 1:0] register_file_read_data,
    
    // UART tranmsitter busy signal after synchronization
    input transmitter_busy_synchronized,
    input transmitter_Q_pulse_generator,

    // UART receiver message after synchronization
    input receiver_parallel_data_valid_synchronized,
    input [DATA_WIDTH - 1:0] receiver_parallel_data_synchronized,

    // ALU control signals
    output [3:0] ALU_function,
    output ALU_enable,
    output ALU_clk_enable,

    // UART transmitter data (the data that it will transmit)
    output transmitter_parallel_data_valid,
    output [DATA_WIDTH - 1:0] transmitter_parallel_data,

    // Register file control signals
    output [$clog2(REGISTER_FILE_DEPTH) - 1:0] register_file_address,
    output register_file_write_enable,
    output [DATA_WIDTH - 1:0] register_file_write_data,
    output register_file_read_enable
);

    wire receiver_controller_enable;

    // UART transmitter controller instantiation
    UART_transmitter_controller #(
        .DATA_WIDTH(DATA_WIDTH)
    ) U_UART_transmitter_controller(
        .clk(clk),
        .reset(reset),
        .ALU_result_valid(ALU_result_valid),
        .ALU_result(ALU_result),
        .read_data_valid(register_file_read_data_valid),
        .read_data(register_file_read_data),
        .transmitter_busy_synchronized(transmitter_busy_synchronized),

        .transmitter_Q_pulse_generator(transmitter_Q_pulse_generator),
        .transmitter_parallel_data_valid(transmitter_parallel_data_valid),
        .transmitter_parallel_data(transmitter_parallel_data),
        .UART_receiver_controller_enable(receiver_controller_enable)
    );

    // UART receiver controller instantiation
    UART_receiver_controller #(
        .DATA_WIDTH(DATA_WIDTH),
        .REGISTER_FILE_DEPTH(REGISTER_FILE_DEPTH)
    ) U_UART_receiver_controller(
        .clk(clk),
        .reset(reset),
        .enable(receiver_controller_enable),
        .parallel_data_valid_synchronized(receiver_parallel_data_valid_synchronized),
        .parallel_data_synchronized(receiver_parallel_data_synchronized),

        .ALU_function(ALU_function),
        .ALU_enable(ALU_enable),
        .ALU_clk_enable(ALU_clk_enable),
        .address(register_file_address),
        .write_enable(register_file_write_enable),
        .write_data(register_file_write_data),
        .read_enable(register_file_read_enable)
    );

endmodule