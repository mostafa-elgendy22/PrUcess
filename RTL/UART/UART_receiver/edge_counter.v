module edge_counter (
    input clk,
    input reset,
    input [5:0] prescale,
    input enable,

    output reg [4:0] edge_count,
    output reg edge_count_done
);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            edge_count <= 5'b0;
        end
        else if (enable && !edge_count_done) begin
            edge_count <= edge_count + 5'b1;
        end
        else begin
            edge_count <= 5'b0;
        end
    end

    always @(*) begin
        case (prescale)
            
            // prescale = 32
            6'b10_0000: begin
                if (edge_count == 5'b11111) begin
                    edge_count_done = 1'b1;
                end
                else begin
                    edge_count_done = 1'b0;
                end
            end
            
            // prescale = 16
            6'b01_0000: begin
                if (edge_count[3:0] == 4'b1111) begin
                    edge_count_done = 1'b1;
                end
                else begin
                    edge_count_done = 1'b0;
                end
            end
            
            // prescale = 8
            6'b00_1000: begin
                if (edge_count[2:0] == 3'b111) begin
                    edge_count_done = 1'b1;
                end
                else begin
                    edge_count_done = 1'b0;
                end
            end

            default: begin
                edge_count_done = 1'b0;
            end
        endcase
    end

endmodule