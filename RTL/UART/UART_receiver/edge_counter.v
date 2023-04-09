/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* clk:             UART clock.
* reset:           Global active low asynchronous reset after synchronization.
* prescale:        The ratio between the frequency of the receiver and the frequecy of the 
*                  transmitter (The avaialable prescale values are: 8, 16, 32).
* enable:          A signal to enable the operation of the edge counter.
* 
* ----------------------------- Outputs -----------------------------
* edge_count:      A counter value which indicates the number of the current edge. Its value
*                  depends on the prescale value (because prescale of value 8 means that the 
*                  counter should stop at 7 and wrap around again).
* edge_count_done: A signal to indicate that a full cycle of the UART tranmsitter has passed
*                  (when prescale value is 8, edge_count_done becomes high when the edge
*                  counter value is 7).
*/

module edge_counter (
    input clk,
    input reset,
    input [5:0] prescale,
    input enable,

    output reg [4:0] edge_count,
    output reg edge_count_done
);

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            edge_count <= 5'b0;
        end
        else if (enable & ~edge_count_done) begin
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