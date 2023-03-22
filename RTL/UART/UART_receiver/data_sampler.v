module data_sampler (
    input clk,
    input reset,
    input serial_data,
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
        if (!reset) begin
            samples <= 3'b0;
            sample_enable <= 1'b0;
        end
        else if (enable) begin
            case (edge_count)
                
                sampling_edge_number: begin
                    samples[0] <= serial_data;
                    sample_enable <= 1'b0;
                end

                sampling_edge_number + 4'd1: begin
                    samples[1] <= serial_data;
                    sample_enable <= 1'b0;
                end
                
                sampling_edge_number + 4'd2: begin
                    samples[2] <= serial_data;
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