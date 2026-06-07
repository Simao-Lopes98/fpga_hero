/*
Top module for counter design
This is a FSM which waits for a btn press,
counts to 0xF, waits for another btn press and decrements 
the count to zero 
*/


module top (
    input      [1:0]    pmod,
    input               clk,
    output reg [3:0]    led
);

    wire    btn_start; 
    wire    btn_reset;

    assign  btn_start = ~pmod[0]; 
    assign  btn_reset = ~pmod[1]; 

    localparam STATE_IDLE       = 'b00;
    localparam STATE_COUNT_UP   = 'b01;
    localparam STATE_COUNT_DOWN = 'b10;

    localparam LED_MIN_VAL      = 'b0000;
    localparam LED_MAX_VAL      = 'b1111;
    localparam LED_DEFAUL_VAL   = 'b1010;
    localparam LED_MOD_VAL      = 'b1;

    localparam BTN_PRESSED      = 'b1;
    localparam BTN_N_PRESSED    = 'b0;

    /* Internal registers */
    reg [2:0] state;
    
    reg dbc_btn_start;

    /* Instantiate btn debounce module */
    debounce_btn debounce_start (
        .btn (btn_start),
        .clk (clk),
        .dbc_btn (dbc_btn_start)
    );

    /* Instantiate clk div */

    clock_div clk_div (
        .clk (clk),
        .rst (btn_reset),
        .out (clk_div)
    );

    /* Override the max count */
    defparam clk_div.MAX_COUNT = 3000000 - 1;

    /* FTM State Logic */
    always @(posedge clk or posedge btn_reset) begin
        if (btn_reset == BTN_PRESSED) begin
            state <= STATE_IDLE;
        end else begin
            case (state) 
                STATE_IDLE: begin
                    if (led == LED_MIN_VAL && 
                        dbc_btn_start == BTN_PRESSED) begin
                        state <= STATE_COUNT_UP;
                    end else if (led == LED_MAX_VAL && 
                                dbc_btn_start == BTN_PRESSED) begin
                        state <= STATE_COUNT_DOWN;
                    end else begin
                        /* Do nothing */
                        state <= STATE_IDLE;
                    end
                end
                STATE_COUNT_UP: begin
                    if (led == LED_MAX_VAL) begin
                        state <= STATE_IDLE;
                    end
                end
                STATE_COUNT_DOWN: begin
                    if (led == LED_MIN_VAL) begin
                        state <= STATE_IDLE;
                    end
                end
                default: begin
                    state <= STATE_IDLE;
                end
            endcase
        end
    end

    /* LED Logic */
    always @(posedge clk_div or posedge btn_reset) begin
        if (btn_reset == BTN_PRESSED) begin
            led <= LED_MIN_VAL;
        end else begin
            case (state)
                STATE_IDLE: led <= led;
                STATE_COUNT_UP: begin
                    if (led < LED_MAX_VAL) begin
                        led <= led + LED_MOD_VAL;
                    end
                end 
                STATE_COUNT_DOWN: begin
                    if (led > LED_MIN_VAL) begin
                        led <= led - LED_MOD_VAL;
                    end
                end
                default: led <= LED_DEFAUL_VAL;
            endcase
        end
    end
endmodule
