/*
debounce_tb module - Testbench for the button debounce lesson
*/

/* Defines timescale for simulation: <time unit> / <time precision> */
`timescale 1 ns / 10 ps

module debounce_tb ();
    
    /* UUT parameters */
    wire dbc;

    reg clk = 0;
    reg btn = 0;

    /* Simulation time: 10000 * 1ns = 10us*/
    localparam SIM_DURATION = 10000;

    /* Run simulation output file */
    initial begin

        /*
        0 here means that the TB will show all signals (most verbose)
        a higher level limits the depth of signals dumped
        */
        $dumpvars(0, debounce_tb);
        
        /* Wait this amount of time before finishing SIM */
        #(SIM_DURATION);

        $display("Finished");
        $finish;
    end

    debounce uut (
        .clk(clk),
        .btn(btn),
        .dbc(dbc)
    );

    /* define counter size - reduce to for this test */
    defparam uut.DB_COUNTER_MAX     = 10;
    defparam uut.DB_COUNTER_SIZE    = 4;

    /* toggle clock */
    /* Generate clk signal: 1 / ((2 * 41.667) * 1 ns) ~= 12 MHz */
    always begin
        /* Delay for 41.67 time units */        
        #41.667

        clk = ~clk;
    end

    integer i;
    
    always begin
        #400
        /* Simulation for noise */
        for (i = 0; i < 5; i = i + 1) begin
            #100
            btn = ~btn;
        end


        /* Btn pressed */
        #840
        btn = 1;

        for (i = 0; i < 5; i = i + 1) begin
             #100
            btn = ~btn;
        end

        /* Btn not pressed  */
        #840
        btn = 0;
    end

endmodule