/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* bit_select:  The output mux selection bits that selects the output 
*              bit (start bit, serial data bit, parity bit, stop bit).
* serial_data: The bit that is serially transmitted from the UART transmitter.
* parity_bit:  The parity bit of the parallel data to be transmitted.
* 
* ----------------------------- Outputs -----------------------------
* mux_out:     The output of the mux that selects between start, serial data, parity, 
*              or stop bits according to the state of the transmission).
*/

module output_multiplexer # (
    // Bit select values
    parameter [1:0] START_BIT_SELECT = 2'b00,
    parameter [1:0] STOP_BIT_SELECT = 2'b01,
    parameter [1:0] SERIAL_DATA_BIT_SELECT = 2'b10,
    parameter [1:0] PARITY_BIT_SELECT = 2'b11
)
(
    input [1:0] bit_select,
    input serial_data,
    input parity_bit,

    output reg mux_out
);

    always @(*) begin
        case (bit_select)
        START_BIT_SELECT: begin
            mux_out = 1'b0;
        end

        STOP_BIT_SELECT: begin
            mux_out = 1'b1;
        end

        SERIAL_DATA_BIT_SELECT: begin
            mux_out = serial_data;
        end

        PARITY_BIT_SELECT: begin
            mux_out = parity_bit;
        end

        endcase
    end

endmodule