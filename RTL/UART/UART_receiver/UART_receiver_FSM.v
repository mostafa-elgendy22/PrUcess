/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:              UART clock.
* reset:            Global active low asynchronous reset after synchronization.
* parity_enable:    A signal to enable the transmission of the parity bit in the frame.
* prescale:         The ratio between the frequency of the receiver and the frequecy of the 
*                   transmitter (The avaialable prescale values are: 8, 16, 32).
* serial_data_in:   The data which is received serially.
* start_bit_error:  A signal to indicate that the sampled start bit is wrong 
*                   (i.e. the samples are 011 or 111 or 110 or 101).
* parity_bit_error: A signal to indicate that the sampled parity bit is wrong.
* stop_bit_error:   A signal to indicate that the sampled stop bit is wrong
*                   (i.e. the samples are 100 or 000 or 001 or 010).
* edge_count:       A counter value which indicates the number of the current edge. Its value
*                   depends on the prescale value (because prescale of value 8 means that the 
*                   counter should stop at 7 and wrap around again).
* edge_count_done:  A signal to indicate that a full cycle of the UART tranmsitter has passed
*                   (when prescale value is 8, edge_count_done becomes high when the edge
*                   counter value is 7).
* ----------------------------- Outputs -----------------------------
* start_bit_check_enable:               A signal to enable the operation of the start bit checker.
* parity_bit_check_enable:              A signal to enable the operation of the parity bit checker.
* stop_bit_check_enable:                A signal to enable the operation of the stop bit checker.
* edge_counter_and_data_sampler_enable: A signal to enable the operation of the edge counter 
*                                       and data sampler.
* deserializer_enable:                  A signal to enable the operation of the deserializer.
* data_index:                           The index of the of bit to be received in the frame.
* data_valid:                           A signal to indicate that the received data by the UART 
*                                       receiver was free of errors.
*/

module UART_receiver_FSM #(
    parameter DATA_WIDTH = 8
)
(
    input clk,
    input reset,
    input parity_enable,
    input [5:0] prescale,
    input serial_data_in,
    input start_bit_error,
    input parity_bit_error,
    input stop_bit_error,
    input [4:0] edge_count,
    input edge_count_done,

    output reg start_bit_check_enable,
    output reg parity_bit_check_enable,
    output reg stop_bit_check_enable,
    output reg edge_counter_and_data_sampler_enable,
    output reg deserializer_enable,
    output [$clog2(DATA_WIDTH) - 1:0] data_index,
    output reg data_valid
);

    wire [5:0] sampling_edge_number;
    wire [5:0] final_edge_number;

    // FSM state register signals
    reg [2:0] current_state;
    reg [2:0] next_state;


    // FSM state encoding
    localparam [2:0] IDLE = 3'b000;
    localparam [2:0] START_BIT_RECEPTION = 3'b001;
    localparam [2:0] SERIAL_DATA_RECEPTION = 3'b010;
    localparam [2:0] PARITY_BIT_RECEPTION = 3'b011;
    localparam [2:0] STOP_BIT_RECEPTION = 3'b100;
    localparam [2:0] DATA_VALID = 3'b101;


    // A register that saves the index of the bit to be received
    // When the value of this register equals 1000, this means that the byte is completely received
    reg [$clog2(DATA_WIDTH):0] data_transmission_state;


    assign final_edge_number = prescale - 6'd2;

    // 'Data index' register
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            data_transmission_state <= 'b0;
        end
        else if (current_state == SERIAL_DATA_RECEPTION && edge_count == final_edge_number) begin 
            data_transmission_state <= data_transmission_state + 'b1;
        end
        else if (data_transmission_state[$clog2(DATA_WIDTH)]) begin
            data_transmission_state <= 'b0;
        end
    end

    assign data_index = data_transmission_state[$clog2(DATA_WIDTH) - 1:0];

    // State transition
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end


    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (~serial_data_in) begin
                    next_state = START_BIT_RECEPTION;
                end
                else begin
                    next_state = IDLE;
                end
            end

            START_BIT_RECEPTION: begin
                if (edge_count_done & start_bit_error) begin
                        next_state = IDLE;
                end
                else if (edge_count_done) begin
                        next_state = SERIAL_DATA_RECEPTION;
                end
                else begin
                    next_state = START_BIT_RECEPTION;
                end
            end

            SERIAL_DATA_RECEPTION: begin
                if (edge_count_done) begin
                    // The byte is not completely received yet
                    if (~data_transmission_state[$clog2(DATA_WIDTH)]) begin
                        next_state = SERIAL_DATA_RECEPTION;
                    end
                    else if (parity_enable) begin
                        next_state = PARITY_BIT_RECEPTION;
                    end
                    else begin
                        next_state = STOP_BIT_RECEPTION;
                    end
                end
                else begin
                    next_state = SERIAL_DATA_RECEPTION;
                end
            end

            PARITY_BIT_RECEPTION: begin
                if (edge_count_done & parity_bit_error) begin
                    next_state = IDLE;
                end
                else if (edge_count_done) begin
                    next_state = STOP_BIT_RECEPTION;
                end
                else begin
                    next_state = PARITY_BIT_RECEPTION;
                end
            end

            STOP_BIT_RECEPTION: begin
                if (edge_count_done & stop_bit_error) begin
                    next_state = IDLE;
                end
                else if (edge_count_done) begin
                    next_state = DATA_VALID;
                end
                else begin
                    next_state = STOP_BIT_RECEPTION;
                end
            end

            DATA_VALID: begin
                if (~serial_data_in) begin
                    next_state = START_BIT_RECEPTION;
                end
                else begin
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

   

    assign sampling_edge_number = (prescale >> 1) - 4'd3;

    // Output logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                edge_counter_and_data_sampler_enable = 1'b0;
                deserializer_enable = 1'b0;
                start_bit_check_enable = 1'b0;
                parity_bit_check_enable = 1'b0;
                stop_bit_check_enable = 1'b0;
                data_valid = 1'b0;
            end

            START_BIT_RECEPTION: begin
                edge_counter_and_data_sampler_enable = 1'b1;
                deserializer_enable = 1'b0;

                if (edge_count == sampling_edge_number + 4'd5) begin
                    start_bit_check_enable = 1'b1;
                end
                else begin
                    start_bit_check_enable = 1'b0;
                end

                parity_bit_check_enable = 1'b0;
                stop_bit_check_enable = 1'b0;
                data_valid = 1'b0;
            end

            SERIAL_DATA_RECEPTION: begin
                edge_counter_and_data_sampler_enable = 1'b1;
                
                if (edge_count == sampling_edge_number + 4'd5) begin
                    deserializer_enable = 1'b1;
                end
                else begin
                    deserializer_enable = 1'b0;
                end

                start_bit_check_enable = 1'b0;
                parity_bit_check_enable = 1'b0;
                stop_bit_check_enable = 1'b0;
                data_valid = 1'b0;
            end

            PARITY_BIT_RECEPTION: begin
                edge_counter_and_data_sampler_enable = 1'b1;
                deserializer_enable = 1'b0;
                start_bit_check_enable = 1'b0;

                if (edge_count == sampling_edge_number + 4'd5) begin
                    parity_bit_check_enable = 1'b1;
                end
                else begin
                    parity_bit_check_enable = 1'b0;
                end

                stop_bit_check_enable = 1'b0;
                data_valid = 1'b0;
            end

            STOP_BIT_RECEPTION: begin
                edge_counter_and_data_sampler_enable = 1'b1;
                deserializer_enable = 1'b0;
                start_bit_check_enable = 1'b0;
                parity_bit_check_enable = 1'b0;

                if (edge_count == sampling_edge_number + 4'd5) begin
                    stop_bit_check_enable = 1'b1;
                end
                else begin
                    stop_bit_check_enable = 1'b0;
                end
                
                data_valid = 1'b0;
            end


            DATA_VALID: begin
                edge_counter_and_data_sampler_enable = 1'b0;
                deserializer_enable = 1'b0;
                start_bit_check_enable = 1'b0;
                parity_bit_check_enable = 1'b0;
                stop_bit_check_enable = 1'b0;
                data_valid = 1'b1;
            end

            default: begin
                edge_counter_and_data_sampler_enable = 1'b0;
                deserializer_enable = 1'b0;
                start_bit_check_enable = 1'b0;
                parity_bit_check_enable = 1'b0;
                stop_bit_check_enable = 1'b0;
                data_valid = 1'b0;
            end

        endcase
    end

endmodule