/*
Adder module
*/

module adder (
    input   [2:0] pmod,
    output  [4:0] led
);
    /* Invert input logic */
    wire A = ~pmod[0];
    wire B = ~pmod[1];
    wire C = ~pmod[2];

    /* Sum singal */
    assign led[0] = A ^ B ^ C;

    /* Carry out signal */
    assign led[1] = (A & B) | (C & (A ^ B));

    assign led[4:2] = 0;


endmodule