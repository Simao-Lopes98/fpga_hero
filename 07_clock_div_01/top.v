/* Top Module */

module top (
    input           clk,
    input           pmod,

    output          [1:0] led
);

    wire rst_btn;

    assign rst_btn = ~pmod;

    clock_div #(.COUNT_WIDTH (32), .MAX_COUNT(1500000 - 1)) 
    div_1 (
        .clk(clk),
        .rst(rst_btn),
        .out(led[0])
    );

    clock_div div_2 (
        .clk(clk),
        .rst(rst_btn),
        .out(led[1])
    );

endmodule