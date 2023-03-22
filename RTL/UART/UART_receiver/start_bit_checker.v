module start_bit_checker (
    input clk,
    input reset,
    input enable,
    input sampled_bit,
    
    output reg start_bit_error 
);

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            start_bit_error <= 1'b0;
        end
        else if (enable) begin
            start_bit_error <= sampled_bit;
        end
        else begin
            start_bit_error <= 1'b0;
        end
    end

endmodule