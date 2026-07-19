/*
12 MHz clk into a 1 Hz module
*/


module clk_sec_pre (
    input   clk,
    output  reg sec_clk
);
    parameter COUNTER_SIZE = 6000000;
    
    reg [31:0] counter;
    initial sec_clk = 1'b0;


    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == COUNTER_SIZE) begin
            /* Toggle sec signal */
            sec_clk <= ~sec_clk;
            /* Reset counter */
            counter <= 0;
        end
    end
endmodule