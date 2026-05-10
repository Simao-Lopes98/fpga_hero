/* 
AND GATE - When buttons 1 and 2 are pressed, turn on LED
*/


module and_gate (
        input pmod_0,
        input pmod_1,
        output led_0
        );

assign led_0 = ~pmod_1 & ~pmod_0;

endmodule