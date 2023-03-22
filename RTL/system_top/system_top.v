`include "../UART/UART/UART.v"
`include "../register_file/register_file.v"
`include "../clock_divider/clock_divider.v"
`include "../reset_synchronizer/reset_synchronizer.v"
`include "../system_controller/system_controller.v"
`include "../ALU/ALU.v"
`include "../clock_gating_cell/clock_gating_cell.v"
`include "../data_synchronizer/data_synchronizer.v"

module system_top #(
    parameter DATA_WIDTH = 8,
    parameter REGISTER_FILE_DEPTH = 16,
    parameter SYNCHRONIZER_STAGE_COUNT = 2
)
(
    input reference_clk,
    input UART_clk,
    input reset,
    input serial_data_in,

    output serial_data_out,
    output parity_error,
    output frame_error
);
    localparam BUS_SYNCHRONIZER_BUS_WIDTH = 1;
    wire transmitter_Q_pulse_generator_synchronized;
    wire receiver_Q_pulse_generator;

    // Synchronized reset signal for each clock domain
    wire UART_reset_synchronized;
    wire reference_reset_synchronized;

    
    // System controller inputs
    wire UART_transmitter_busy_synchronized;
    wire receiver_parallel_data_valid_synchronized;
    wire [DATA_WIDTH - 1:0] receiver_parallel_data_synchronized;

    // ALU inputs
    wire [3:0] ALU_function;
    wire ALU_enable;

    // ALU outputs
    wire ALU_result_valid;
    wire [2 * DATA_WIDTH - 1:0] ALU_result;

    // Clock gating cell enable
    wire ALU_clk_enable;

    // ALU gated clock
    wire ALU_clk;

    // The first four registers in the register file
    wire [DATA_WIDTH - 1:0] ALU_operand_A;
    wire [DATA_WIDTH - 1:0] ALU_operand_B;
    wire [DATA_WIDTH - 1:0] UART_parity_configuration;
    wire [DATA_WIDTH - 1:0] UART_prescale_configuration;

    // Register file inputs
    wire [$clog2(REGISTER_FILE_DEPTH) - 1:0] register_file_address;
    wire register_file_write_enable;
    wire [DATA_WIDTH - 1:0] register_file_write_data;
    wire register_file_read_enable;

    // Register file outputs
    wire register_file_read_data_valid;
    wire [DATA_WIDTH - 1:0] register_file_read_data;

    // UART transmitter controller outputs
    wire transmitter_parallel_data_valid;
    wire [DATA_WIDTH - 1:0] transmitter_parallel_data;

    // UART inputs
    wire UART_transmitter_clk;
    wire transmitter_parallel_data_valid_synchronized;
    wire [DATA_WIDTH - 1:0] transmitter_parallel_data_synchronized;
    
    // UART outputs
    wire transmitter_Q_pulse_generator;
    wire receiver_parallel_data_valid;
    wire [DATA_WIDTH - 1:0] receiver_parallel_data;
    wire UART_transmitter_busy;

    // Clock divider enable
    wire clk_divider_enable;
    assign clk_divider_enable = 1'b1;

    // ------------------------ Clock Domain '1' (REFERENCE_CLK) --------------------
    reset_synchronizer #(
        .STAGE_COUNT(SYNCHRONIZER_STAGE_COUNT)
    )
    U_reference_reset_synchronizer(
        .clk(reference_clk),
        .reset(reset),

        .reset_synchronized(reference_reset_synchronized)
    );

    system_controller #(
        .DATA_WIDTH(DATA_WIDTH),
        .REGISTER_FILE_DEPTH(REGISTER_FILE_DEPTH)
    )
    U_system_controller(
        .clk(reference_clk),
        .reset(reference_reset_synchronized),
        .ALU_result_valid(ALU_result_valid),
        .ALU_result(ALU_result),
        .register_file_read_data_valid(register_file_read_data_valid),
        .register_file_read_data(register_file_read_data),
        .transmitter_busy_synchronized(UART_transmitter_busy_synchronized),
        .transmitter_Q_pulse_generator(transmitter_Q_pulse_generator_synchronized),
        .receiver_parallel_data_valid_synchronized(receiver_parallel_data_valid_synchronized),
        .receiver_parallel_data_synchronized(receiver_parallel_data_synchronized),

        .ALU_function(ALU_function),
        .ALU_enable(ALU_enable),
        .ALU_clk_enable(ALU_clk_enable),
        .transmitter_parallel_data_valid(transmitter_parallel_data_valid),
        .transmitter_parallel_data(transmitter_parallel_data),
        .register_file_address(register_file_address),
        .register_file_write_enable(register_file_write_enable),
        .register_file_write_data(register_file_write_data),
        .register_file_read_enable(register_file_read_enable)
    );

    clock_gating_cell U_clock_gating_cell(
        .clk(reference_clk),
        .clk_enable(ALU_clk_enable),

        .gated_clock(ALU_clk)
    );

    ALU #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_ALU(
        .clk(ALU_clk),
        .reset(reference_reset_synchronized),
        .A(ALU_operand_A),
        .B(ALU_operand_B),
        .ALU_function(ALU_function),
        .enable(ALU_enable),
        
        .ALU_result_valid(ALU_result_valid),
        .ALU_result(ALU_result)
    );

    register_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .REGISTER_FILE_DEPTH(REGISTER_FILE_DEPTH) 
    )
    U_register_file(
        .clk(reference_clk),
        .reset(reference_reset_synchronized),
        .address(register_file_address),
        .write_enable(register_file_write_enable),
        .write_data(register_file_write_data),
        .read_enable(register_file_read_enable),
        
        .read_data_valid(register_file_read_data_valid),
        .read_data(register_file_read_data),
        .register0(ALU_operand_A),
        .register1(ALU_operand_B),
        .register2(UART_parity_configuration),
        .register3(UART_prescale_configuration)
    );

    bus_synchronizer #(
        .STAGE_COUNT(SYNCHRONIZER_STAGE_COUNT),
        .BUS_WIDTH(BUS_SYNCHRONIZER_BUS_WIDTH)
    )
    U_busy_bit_synchronizer(
        .clk(reference_clk),
        .reset(reference_reset_synchronized),
        .asynchronous_data(UART_transmitter_busy),

        .synchronous_data(UART_transmitter_busy_synchronized)
    );

    bus_synchronizer #(
        .STAGE_COUNT(SYNCHRONIZER_STAGE_COUNT),
        .BUS_WIDTH(BUS_SYNCHRONIZER_BUS_WIDTH)
    )
    U_Q_pulse_generator_bit_synchronizer(
        .clk(reference_clk),
        .reset(reference_reset_synchronized),
        .asynchronous_data(transmitter_Q_pulse_generator),

        .synchronous_data(transmitter_Q_pulse_generator_synchronized)
    );
    

    data_synchronizer #(
        .STAGE_COUNT(SYNCHRONIZER_STAGE_COUNT),
        .BUS_WIDTH(DATA_WIDTH)
    )
    U_UART_receiver_data_synchronizer(
        .clk(reference_clk),
        .reset(reference_reset_synchronized),
        .asynchronous_data_valid(receiver_parallel_data_valid),
        .asynchronous_data(receiver_parallel_data),

        .Q_pulse_generator(receiver_Q_pulse_generator),
        .synchronous_data_valid(receiver_parallel_data_valid_synchronized),
        .synchronous_data(receiver_parallel_data_synchronized)
    );

    // ------------------------------------------------------------------------------
    
    // ------------------------ Clock Domain '2' (UART_CLK) --------------------
    reset_synchronizer #(
        .STAGE_COUNT(SYNCHRONIZER_STAGE_COUNT)
    )
    U_UART_reset_synchronizer(
        .clk(UART_clk),
        .reset(reset),

        .reset_synchronized(UART_reset_synchronized)
    );

    UART #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    U_UART(
        .transmitter_clk(UART_transmitter_clk),
        .receiver_clk(UART_clk),
        .reset(UART_reset_synchronized),
        .parity_type(UART_parity_configuration[1]),
        .parity_enable(UART_parity_configuration[0]),
        .prescale(UART_prescale_configuration[DATA_WIDTH - 3:0]),
        .transmitter_parallel_data_valid(transmitter_parallel_data_valid_synchronized),
        .transmitter_parallel_data(transmitter_parallel_data_synchronized),
        .serial_data_receiver(serial_data_in),
        
        .transmitter_busy(UART_transmitter_busy),
        .serial_data_transmitter(serial_data_out),
        .receiver_parallel_data_valid(receiver_parallel_data_valid),
        .receiver_parallel_data(receiver_parallel_data),
        .parity_error_receiver(parity_error),
        .frame_error_receiver(frame_error)
    );

    clock_divider U_clock_divider (
        .reference_clk(UART_clk),
        .reset(UART_reset_synchronized),
        .clk_divider_enable(clk_divider_enable),
        .division_ratio(UART_prescale_configuration[DATA_WIDTH - 3:0]),

        .output_clk(UART_transmitter_clk)
    );

    data_synchronizer #(
        .STAGE_COUNT(SYNCHRONIZER_STAGE_COUNT),
        .BUS_WIDTH(DATA_WIDTH)
    )
    U_UART_transmitter_data_synchronizer(
        .clk(UART_transmitter_clk),
        .reset(UART_reset_synchronized),
        .asynchronous_data_valid(transmitter_parallel_data_valid),
        .asynchronous_data(transmitter_parallel_data),

        .Q_pulse_generator(transmitter_Q_pulse_generator),
        .synchronous_data_valid(transmitter_parallel_data_valid_synchronized),
        .synchronous_data(transmitter_parallel_data_synchronized)
    );
    // ------------------------------------------------------------------------------

endmodule