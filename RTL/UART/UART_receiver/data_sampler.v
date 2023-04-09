/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:            UART clock.
* reset:          Global active low asynchronous reset after synchronization.
* serial_data_in: The data which is received serially.
* prescale:       The ratio between the frequency of the receiver and the frequecy of the 
*                 transmitter (The avaialable prescale values are: 8, 16, 32).
*                 This is the 5 MSBs of the prescale, becuase the data sampler module operates 
*                 on the prescale after shifting its value.
* enable:         A signal to enable the data sampler.
* edge_count:     A counter value which indicates the number of the current edge. Its value
*                 depends on the prescale value (because prescale of value 8 means that the 
*                 counter should stop at 7 and wrap around again).
*
* ----------------------------- Outputs -----------------------------
* sampled_bit:    The resulting sampled bit out of three samples taken at three different edges.
*                 It is equal to the bit appearing the most times in the samples
*                 (e.g. if samples = 101, sampled_bit = 1. if samples = 100, sampled_bit = 0).
*/

module data_sampler (
    input clk,
    input reset,
    input serial_data_in,
    input [4:0] prescale,
    input enable,
    input [4:0] edge_count,

    output reg sampled_bit
);
    wire [4:0] sampling_edge_number;
    reg [2:0] samples;
    reg sample_enable;


    assign sampling_edge_number = prescale - 4'd2;

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            samples <= 3'b0;
            sample_enable <= 1'b0;
        end
        else if (enable) begin
            case (edge_count)
                
                sampling_edge_number: begin
                    samples[0] <= serial_data_in;
                    sample_enable <= 1'b0;
                end

                sampling_edge_number + 4'd1: begin
                    samples[1] <= serial_data_in;
                    sample_enable <= 1'b0;
                end
                
                sampling_edge_number + 4'd2: begin
                    samples[2] <= serial_data_in;
                    sample_enable <= 1'b0;
                end

                sampling_edge_number + 4'd3: begin
                    sample_enable <= 1'b1;
                end

                default: begin
                    sample_enable <= 1'b0;
                end
            endcase
        end
    end

    always @(*) begin
        if (sample_enable) begin
            case (samples)
                3'b000: begin
                    sampled_bit = 1'b0;
                end

                3'b001: begin
                    sampled_bit = 1'b0;
                end

                3'b010: begin
                    sampled_bit = 1'b0;
                end

                3'b011: begin
                    sampled_bit = 1'b1;
                end

                3'b100: begin
                    sampled_bit = 1'b0;
                end

                3'b101: begin
                    sampled_bit = 1'b1;
                end

                3'b110: begin
                    sampled_bit = 1'b1;
                end

                3'b111: begin
                    sampled_bit = 1'b1;
                end
            endcase
        end
        else begin
            sampled_bit = 1'b0;
        end
    end

endmodule