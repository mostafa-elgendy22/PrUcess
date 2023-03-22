module clock_divider (
    input reference_clk,
    input reset,
    input clk_divider_enable,
    input [5:0] division_ratio,

    output output_clk
);

    reg [4:0] counter;
    reg divided_clk;
    reg odd_toggle;
    wire [4:0] ratio_divided_by_two;
    wire enable;


    always @(posedge reference_clk or negedge reset) begin
        if (~reset) begin
            divided_clk <= 1'b0;
            odd_toggle <= 1'b1;
            counter <= 5'b0;
        end
        else if (enable) begin
            if (~division_ratio[0] & counter == ratio_divided_by_two - 1'b1) begin
                divided_clk <= ~divided_clk;
                counter <= 5'b0;
            end
            else if (division_ratio[0] & ((counter == ratio_divided_by_two - 1'b1 & odd_toggle)
                                        | (counter == ratio_divided_by_two & ~odd_toggle))) begin
                divided_clk <= ~divided_clk;
                odd_toggle <= ~odd_toggle;
                counter <= 5'b0;
            end
            else begin
                counter <= counter + 5'b1;
            end
        end
    end

    assign enable = clk_divider_enable | (division_ratio != 6'b00_0001) | (division_ratio != 6'b00_0000);
    assign ratio_divided_by_two = (division_ratio >> 1);
    assign output_clk = clk_divider_enable ? divided_clk : reference_clk;


endmodule