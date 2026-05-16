/*
Counter module - Count up each time clk is pulsed. 
*/


module counter (
    input      [1:0]    pmod,
    input               clk,
    output reg [3:0]    led
);

    wire rst;
    wire clk_sec;
    wire clk_btn;

    /* Invert logic */
    assign rst = ~pmod[0];
    assign clk_btn = ~pmod[1];

    clk_sec_pre sec_pre (
        .clk (clk),
        .sec_clk (clk_sec)
    );
    /* Sequential */
    always @(posedge clk_sec or posedge rst) begin
        
        if (rst == 1'b1) begin
            led <= 4'b0000;
        end else begin
            led <= led + 1'b1;
        end

    end
    
endmodule