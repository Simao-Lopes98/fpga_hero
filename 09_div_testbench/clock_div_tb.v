/*
clock_div_tb module - Testbench for the clock divider lesson
*/

/* Defines timescale for simulation: <time_unit> / <time_precision> */
`timescale 1 ns / 10 ps

module clock_div_tb ();
    
    /* Internal signals */
    wire out;

    /* Storage elements */
    reg clk = 0;
    reg rst = 0;

    /* Simulation time: 10000 * 1ns = 10us*/
    localparam SIM_DURATION = 10000;

    /* Run simulation output file */
    initial begin

        /*
        0 here means that the TB will show all signals (most verbose)
        a higher level limits the depth of signals dumped
        */
        $dumpvars(0, clock_div_tb);
        
        /* Wait this amount of time before finishing SIM */
        #(SIM_DURATION);

        $display("Finished");
        $finish;
    end

    /* Toggle reset at the beginning */
    initial begin
        #10
        rst = 'b1;
        #1
        rst = 'b0;
    end

    /* Generate clk signal: 1 / ((2 * 41.667) * 1 ns) ~= 12 MHz */
    always begin
        /* Delay for 41.67 time units */        
        #41.667

        /*Toggle clk */
        clk = ~clk;
    end

    /* Define UUT */
    clock_div uut
    (
        .clk(clk),
        .rst(rst),
        .out(out)
    );
    defparam uut.COUNT_WIDTH    = 4;
    defparam uut.MAX_COUNT      = 6 - 1;

endmodule