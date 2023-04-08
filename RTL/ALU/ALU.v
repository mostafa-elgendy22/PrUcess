/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:              The ALU result is synchronized to this clock (reference clock).
* reset:            Global active low asynchronous reset after synchronization.
* A:                ALU's first operand (it is connected to register_file[0]).
* B:                ALU's second operand (it is connected to register_file[1]).
* ALU_funtion:      A binary code to determine the function of the ALU.
* enable:           ALU enable signal.
* 
* ----------------------------- Outputs -----------------------------
* ALU_result_valid: A signal to indicate the ALU result is valid.
* ALU_result:       The result of the ALU.
*/
module ALU #(
    parameter DATA_WIDTH = 8
)
(
    input clk,
    input reset,
    input [DATA_WIDTH - 1:0] A,
    input [DATA_WIDTH - 1:0] B,
    input [3:0] ALU_function,
    input enable,
    
    output reg ALU_result_valid,
    output reg [2 * DATA_WIDTH - 1:0] ALU_result
);

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            ALU_result <= 'b0;
            ALU_result_valid <= 1'b0;
        end
        else begin
            if (enable) begin
                case (ALU_function)
                    4'b0000: begin
                        ALU_result <= A + B;
                        ALU_result_valid <= 1'b1;
                    end
                    4'b0001: begin
                        ALU_result <= A - B;
                        ALU_result_valid <= 1'b1;
                    end
                    4'b0010: begin
                        ALU_result <= A * B;
                        ALU_result_valid <= 1'b1;
                    end
                    4'b0011: begin
                        ALU_result <= A / B;
                        ALU_result_valid <= 1'b1;
                    end
                    4'b0100: begin
                        ALU_result <= A & B;
                        ALU_result_valid <= 1'b1;
                    end
                    4'b0101: begin
                        ALU_result <= A | B;
                        ALU_result_valid <= 1'b1;
                    end
                    4'b0110: begin
                        ALU_result <= ~(A & B);
                        ALU_result_valid <= 1'b1;
                    end
                    4'b0111: begin
                        ALU_result <= ~(A | B);
                        ALU_result_valid <= 1'b1;
                    end
                    4'b1000: begin
                        ALU_result <= A ^ B;
                        ALU_result_valid <= 1'b1;
                    end
                    4'b1001: begin
                        ALU_result <= ~(A ^ B);
                        ALU_result_valid <= 1'b1;
                    end
                    4'b1010: begin
                        if (A == B) begin
                            ALU_result <= 'b1;
                        end
                        else begin
                            ALU_result <= 'b0;
                        end
                        ALU_result_valid <= 1'b1;
                    end
                    4'b1011: begin
                        if (A > B) begin
                            ALU_result <= 'b1;
                        end
                        else begin
                            ALU_result <= 'b0;
                        end
                        ALU_result_valid <= 1'b1;
                    end
                    4'b1100: begin
                        if (A < B) begin
                            ALU_result <= 'b1;
                        end
                        else begin
                            ALU_result <= 'b0;
                        end
                        ALU_result_valid <= 1'b1;
                    end
                    4'b1101: begin
                        ALU_result <= A >> 1;
                        ALU_result_valid <= 1'b1;
                    end
                    4'b1110: begin
                        ALU_result <= A << 1;
                        ALU_result_valid <= 1'b1;
                    end
                    default: begin
                        ALU_result <= 'b0;
                        ALU_result_valid <= 1'b0;
                    end

                endcase
            end
            else begin
                ALU_result <= 'b0;
                ALU_result_valid <= 1'b0;
            end
            
        end
    end

endmodule