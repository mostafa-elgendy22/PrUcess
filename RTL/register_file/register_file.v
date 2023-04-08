/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:             The read and write operations are synchronized to this clock (reference clock).
* reset:           Global active low asynchronous reset after synchronization.
* address:         The address of the register to be read from or written to.
* write_enable:    A signal to enable the write operation.
* write_data:      The data to be written in the given address.
* read_enable:     A signal to enable the read operation.
* 
* ----------------------------- Outputs -----------------------------
* read_data_valid: A signal to indicate that the data on the 'read_data' bus is a valid data.
* read_data:       The data read from the given address.
* register0:       The first register in the register file, it stores the first operand of the ALU.
* register1:       The second register in the register file, it stores the second operand of the ALU.
* register2:       The third register in the register file, it stores the parity configuration 
*                  (parity enable and parity type) of the UART.
* register3:       The fourth register in the register file, it stores the value of the prescale
*                  used in the clock divider (it is the ratio between the clock frequency of the
*                  UART receiver and the clock frequency of the UART transmitter).
*/
module register_file #(
    parameter DATA_WIDTH = 8,
    parameter REGISTER_FILE_DEPTH = 16
)
(
    input clk,
    input reset,
    input [$clog2(REGISTER_FILE_DEPTH) - 1:0] address,
    input write_enable,
    input [DATA_WIDTH - 1:0] write_data,
    input read_enable,
    
    output reg read_data_valid,
    output reg [DATA_WIDTH - 1:0] read_data,
    output [DATA_WIDTH - 1:0] register0,
    output [DATA_WIDTH - 1:0] register1,
    output [DATA_WIDTH - 1:0] register2,
    output [DATA_WIDTH - 1:0] register3
);

    // Register file declaration
    reg [DATA_WIDTH - 1:0] memory [0:REGISTER_FILE_DEPTH - 1];

    // Integer to index the registers
    integer i;

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            for (i = 0; i < REGISTER_FILE_DEPTH; i = i + 1) begin
                if (i == 2) begin
                    // not used - parity_type - parity_enable
                    memory[i] <= 'b000000_0_1;
                end
                else if (i == 3) begin
                    // not used - division_ratio (same as oversampling prescale)
					memory[i] <= 'b00_001000;
                end
                else begin
                    memory[i] <= 'b0;
                end
            end
            read_data_valid <= 1'b0;
            read_data <= 'b0;
        end
        else if (write_enable & ~read_enable) begin
            memory[address] <= write_data;
            read_data_valid <= 1'b0;
        end
        else if (read_enable & ~write_enable) begin
            read_data <= memory[address];
            read_data_valid <= 1'b1;
        end
        else begin
            read_data_valid <= 1'b0;
        end
    end

    assign register0 = memory[0];
    assign register1 = memory[1];
    assign register2 = memory[2];
    assign register3 = memory[3];

endmodule