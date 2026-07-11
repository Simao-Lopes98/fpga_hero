/*
soc_tb module - Testbench for the SoC decoder
*/

/* Defines timescale for simulation: <time unit> / <time precision> */
`timescale 1 ns / 10 ps

module soc_tb ();

    reg         clk     = 0;
    reg         reset   = 0;

    /* Simtime - 10000 * 1ns =  10 us */
    localparam SIM_DURATION = 10000;

    /* 
    1/12MHz = 83.33 ns 
    83.33 ns / 2 ~= 41.67
    */
    localparam DELAY_PER_EDGE = 41.67;

    localparam DELAY_PER_SYCL = (2 * DELAY_PER_EDGE);

    /* Run simulation output file */
    initial begin

        /*
        0 here means that the TB will show all signals (most verbose)
        a higher level limits the depth of signals dumped
        */
        $dumpvars(0, soc_tb);
        
        /* Wait this amount of time before finishing SIM */
        #(SIM_DURATION);

        $display("Finished");
        $finish;
    end

    /* Generate clock at ~= 12 MHz */
    always begin
        #DELAY_PER_EDGE
        clk = ~clk;
    end

    /* 
    Instantiante the UUT 
    No need to connect other ports
    */
    soc utt (
        .clk(clk),
        .reset(reset)
    );


    /* Run test: Write and read back */
    initial begin
        #DELAY_PER_SYCL
        reset = 1;
        #DELAY_PER_SYCL
        reset = 0;
    end

endmodule
