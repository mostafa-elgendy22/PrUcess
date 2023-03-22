/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:               Generated clock produced from the clock divider whose source clock is
*                    UART clock.
* reset:             Global active low asynchronous reset after synchronization.
* parity_enable:     Signal to enable the transmission of the parity bit in the frame.
* data_valid:        Signal that indicates that there exist data to be transmitted.
* 
* ----------------------------- Outputs -----------------------------
* serial_enable:    The bit that is serially transmitted from the UART transmitter.
* bit_select:       The output mux selection bits that selects the output 
*                   bit (start bit, serial data bit, parity bit, stop bit).
* seial_data_index: A number between 0 and 7 that indicates the index of the bit to be 
*                   transmitted serially.
* busy:             A signal that indicates that the transmitter is currently in operation
*                   and it can't transmit a new byte.
*/

module UART_transmitter_FSM # (
    parameter DATA_WIDTH = 8,

    // Bit select values
    parameter [1:0] START_BIT_SELECT = 2'b00,
    parameter [1:0] STOP_BIT_SELECT = 2'b01,
    parameter [1:0] SERIAL_DATA_BIT_SELECT = 2'b10,
    parameter [1:0] PARITY_BIT_SELECT = 2'b11
)
(
    input clk,
    input reset,
    input parity_enable,
    input data_valid,

    output reg serial_enable,
    output reg [1:0] bit_select,
    output wire [$clog2(DATA_WIDTH) - 1:0] serial_data_index,
    output reg busy
);

    // A register that saves the index of the bit to be transmitted
    // When the value of this register equals 1000, this means that the byte is completely transmitted
    reg [$clog2(DATA_WIDTH):0] serial_data_transmission_state;

    // FSM state register signals
    reg [2:0] current_state;
    reg [2:0] next_state;


    // FSM state encoding
    localparam [2:0] IDLE = 3'b000;
    localparam [2:0] START_BIT_TRANSMISSION = 3'b001;
    localparam [2:0] SERIAL_DATA_TRANSMISSION = 3'b010;
    localparam [2:0] PARTIY_BIT_TRANSMISSION = 3'b011;
    localparam [2:0] STOP_BIT_TRANSMISSION = 3'b100;


    // 'Serial data index' register
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            serial_data_transmission_state <= 'b0;
        end
        // When the current state is 'SERIAL_DATA_TRANSMISSION', it should immediately transmit
        // the bit number 0, so when the current state is 'START_BIT_TRANSMISSION' (which is sampled
        // at the edge just before the current state changes to 'SERIAL_DATA_TRANSMISSION', and at
        // that instant the serial data state is zero which means that this bit will be transmitted 
        // once the state becomes 'SERIAL_DATA_TRANSMISSION')
        // the serial data state should be incremented so that by sampling the data on 
        // the next edge, the transmitter sends the bit number 1 and so on.
        else if (current_state == START_BIT_TRANSMISSION |
                (current_state == SERIAL_DATA_TRANSMISSION 
                 & ~serial_data_transmission_state[$clog2(DATA_WIDTH)])) begin
            serial_data_transmission_state <= serial_data_transmission_state + 'b1;
        end
        else begin
            serial_data_transmission_state <= 'b0;
        end
    end

    assign serial_data_index = serial_data_transmission_state[$clog2(DATA_WIDTH) - 1:0];


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
                if (data_valid)
                begin
                    next_state = START_BIT_TRANSMISSION;
                end
                else
                begin
                    next_state = IDLE;
                end
            end

            START_BIT_TRANSMISSION: begin
                next_state = SERIAL_DATA_TRANSMISSION;
            end

            SERIAL_DATA_TRANSMISSION: begin
                // If the following condition is satisfied, this means that the byte is transmitted
                if (serial_data_transmission_state[$clog2(DATA_WIDTH)])
                begin
                    if (parity_enable)
                    begin
                        next_state = PARTIY_BIT_TRANSMISSION;
                    end
                    else
                    begin
                        next_state = STOP_BIT_TRANSMISSION;
                    end
                end
                else
                begin
                    next_state = SERIAL_DATA_TRANSMISSION;
                end
            end

            PARTIY_BIT_TRANSMISSION: begin
                next_state = STOP_BIT_TRANSMISSION;
            end

            STOP_BIT_TRANSMISSION: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                busy = 1'b0;
                serial_enable = 1'b0;
                // The output at the IDLE state is the same as the stop bit (which is logic 1)
                bit_select = STOP_BIT_SELECT;
            end

            // The serial enable is enabled in this state because just after the sampling edge 
            // of this state, the state becomes 'SERIAL_DATA_TRANSMISSION' which means that the
            // serial data needs to be transmitted immediately
            START_BIT_TRANSMISSION: begin
                busy = 1'b1;
                serial_enable = 1'b1;
                bit_select = START_BIT_SELECT;
            end

            SERIAL_DATA_TRANSMISSION: begin
                busy = 1'b1;
                // If the following condition is satisfied, this means that the byte is transmitted
                if (serial_data_transmission_state[$clog2(DATA_WIDTH)]) begin
                    serial_enable = 1'b0;
                end
                else begin
                    serial_enable = 1'b1;
                end
                
                bit_select = SERIAL_DATA_BIT_SELECT;
            end

            PARTIY_BIT_TRANSMISSION: begin
                busy = 1'b1;
                serial_enable = 1'b0;
                bit_select = PARITY_BIT_SELECT;
            end

            STOP_BIT_TRANSMISSION: begin
                busy = 1'b1;
                serial_enable = 1'b0;
                bit_select = STOP_BIT_SELECT;
            end

            default: begin
                busy = 1'b0;
                serial_enable = 1'b0;
                bit_select = STOP_BIT_SELECT;
            end
        endcase
    end


endmodule