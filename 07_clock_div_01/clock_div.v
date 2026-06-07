/*
Clock Divider module - Divides the input clock frequency
*/


module clock_div #(
        /* parameters */
    parameter   COUNT_WIDTH                 = 24,
    parameter   [COUNT_WIDTH:0] MAX_COUNT   = 6000000 - 1
)
(
    input               clk,
    input               rst,

    output reg          out
);

    localparam  BTN_PRESSED                 = 1'b1;

    /* Internal signals */
    reg         [COUNT_WIDTH:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst == BTN_PRESSED) begin
            count   <= 0;
            out     <= 0;
        end else if (MAX_COUNT == count) begin
            count   <= 0;
            out     <= ~out;
        end else begin
            count   <= count + 1;
        end
    end

endmodule
