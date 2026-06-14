/*
memory_tb module - Testbench for the on-chip memory lesson
*/

/* Defines timescale for simulation: <time unit> / <time precision> */
`timescale 1 ns / 10 ps

module memory_tb ();

    wire [7:0]  r_data;

    reg         clk     = 0;
    reg         w_en    = 0;
    reg         r_en    = 0;
    reg  [3:0]  w_addr  = 0;
    reg  [3:0]  r_addr  = 0;
    reg  [7:0]  w_data  = 0;

    /* for loop */    
    integer i;

    /* Simtime - 10000 * 1ns =  10 us */
    localparam SIM_DURATION = 10000;

    localparam DELAY_PER_EDGE = 41.67;
    /* Clock cycles */
    localparam CLK_CYCLE = (2 * DELAY_PER_EDGE);

    /* Run simulation output file */
    initial begin

        /*
        0 here means that the TB will show all signals (most verbose)
        a higher level limits the depth of signals dumped
        */
        $dumpvars(0, memory_tb);
        
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

    /* Instantiante the UUT */
    memory uut (
        .clk(clk),
        .w_en(w_en),
        .r_en(r_en),
        .w_addr(w_addr),
        .r_addr(r_addr),
        .w_data(w_data),
        .r_data(r_data)
    );

    defparam uut.INIT_FILE = "mem.txt";

    /* Run test: Write and read back */
    initial begin

        /* Test 1: Read all memory addresses */
        for (i = 0; i < 16 ; i = i + 1) begin
            #CLK_CYCLE
            r_addr  = i;
            r_en    = 1;
            #CLK_CYCLE
            r_addr  = 0;
            r_en    = 0;
        end

        /* Test 2: Write to address 0x0F and read it back */
        #CLK_CYCLE
        w_addr  = 'h0f;
        w_data  = 'hDE;
        w_en    = 1;
        #CLK_CYCLE
        w_addr  = 0;
        w_data  = 0;
        w_en    = 0;
        r_addr  = 'h0f;
        r_en    = 1;
        #CLK_CYCLE
        r_addr  = 0;
        r_en    = 0;
    end

endmodule
