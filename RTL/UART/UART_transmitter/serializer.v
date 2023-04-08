/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:               Generated clock produced from the clock divider whose source clock is
*                    UART clock.
* reset:             Global active low asynchronous reset after synchronization.
* parallel_data:     The data to be transmitted by the UART transmitter.
* serial_enable:     A signal to enable the operation of the serializer.
* serial_data_index: A number between 0 and 7 that indicates the index of the bit to be 
*                    transmitted serially.
*
* ----------------------------- Outputs -----------------------------
* serial_data:       The bit that is serially transmitted from the UART transmitter.
*/

module serializer #(
    parameter DATA_WIDTH = 8
)
(
    input clk,
    input reset,
    input [DATA_WIDTH - 1:0] parallel_data,
    input serial_enable,
    input [$clog2(DATA_WIDTH) - 1:0] serial_data_index,
    
    output reg serial_data
);

    // The 'D' signal of the serial data register (output signal)
    wire D_serial_data;

    assign D_serial_data = parallel_data[serial_data_index];

    // Serial data register
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            serial_data <= 1'b0;
        end
        else if (serial_enable) begin
            serial_data <= D_serial_data;
        end
    end


endmodule