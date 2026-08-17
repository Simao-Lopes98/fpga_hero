/*
soc module - a minimal soft RISC-V core running on the ICEStick
*/

`define BENCH

module soc (
    input           clk,
    input           reset,
    input           rx,

    output  [4:0]   led,
    output          tx
);

    /* ---------------------------------------------------------------
       CLOCK / RESET
       reset_p is the active-high, internal version of the (active-low)
       board reset input, sampled synchronously at the top of the FSM's
       posedge clk block to force it back to FETCH_INSTR_STATE.
    --------------------------------------------------------------- */
    
    reg [31:0]  memAddr;
    reg [31:0]  instr;
    reg [31:0]  x1;
    // For continous assingments
    reg [4:0] LEDs;

    // Not used for now
    assign      tx = 0;
    wire        readEn;
    wire        reset_p;
    assign      reset_p = ~reset;
    assign led = LEDs;

    memory RAM (
        .clk        (clk),
        .memAddr    (memAddr),
        .readEn     (readEn),
        .memOut     (instr)
    );

    processor CPU (
        .clk (clk),
        .rst (reset_p),
        .memIn (instr),
        .memOut (memAddr),
        .readEn (readEn),
        .x1 (x1)
    );

    // Prescale CLK for hardware run i.e not sim
    `ifndef BENCH
    clk_sec_pre clk_pre (
        .clk(clk),
        .clk (clk)
    );
    // Reduce counter to achieve 1/2 secs
    defparam  clk_pre.COUNTER_SIZE = 3000000;
    `endif
    
endmodule
