/*
PLL module - use the iCE40 Phased Locked Loop (PLL) to generate a clock
*/


module pll (
    input   ref_clk,

    output  clk
);

    /* Values aquired using: apio raw -- icepll -i 12 -o 120 */
    SB_PLL40_CORE # (
        .FEEDBACK_PATH("SIMPLE"),   /* Do not use fine delay */
        .PLLOUT_SELECT("GENCLK"),   /* No phase shift */
        .DIVR(4'b0000),             /* Reference clk */
        .DIVF(7'b1001111),          /* Feedbakc clk divider */
        .DIVQ(3'b011),              /* VCO clock divider */
        .FILTER_RANGE(3'b001)
    ) pll (
        .REFERENCECLK(ref_clk),
        .PLLOUTCORE(clk),
        .LOCK(),
        .RESETB (1'b1),
        .BYPASS(1'b0)
    );

endmodule
