/* 
AND GATE - Btn 0 turns on 2 LEDs, btn 0 and 1 turn on another LED
*/


module and_gate (
        input   [1:0] pmod,
        output  [2:0] led
        );

    wire not_pmod_0;

    assign not_pmod_0 = ~pmod[0];

    /* same as:
    assign led[0] = not_pmod_0;
    assign led[1] = not_pmod_0;
    */
    assign led[1:0] = {2{not_pmod_0}};

    assign led[2] = not_pmod_0 & ~pmod[1];

endmodule