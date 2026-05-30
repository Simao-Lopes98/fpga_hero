/*
FSM Mealy module - Mealy state machine implementation
*/


module fsm_mealy (
    input      [1:0]    pmod,
    input               clk,
    output reg [3:0]    led,
    output reg          done_sig
);

    wire rst_btn;
    wire go_btn;

    assign rst_btn      =    ~pmod   [0];
    assign go_btn       =    ~pmod   [1];

    /* States */
    localparam STATE_IDLE       = 2'd0;
    localparam STATE_COUNTING   = 2'd1;
    localparam STATE_DONE       = 2'd2;

    localparam BTN_PRESSED      = 1'b1;

    /* Max counts for clock divider and counter */
    localparam MAX_CLK_COUNT    = 24'd1500000;
    localparam ZERO_CLK_COUNT   = 24'd0;
    localparam MAX_LED_COUNT    = 4'hf;
    localparam ZERO_LED_COUNT   = 4'h0;


    /* Internal reg storage for procedural */
    reg         clk_div;
    reg [1:0]   state;
    reg [23:0]  clk_cnt;

    /* Clk div */
    always @(posedge clk or posedge rst_btn) begin
        if (rst_btn == BTN_PRESSED) begin
            clk_cnt <= ZERO_CLK_COUNT;
        end else if (clk_cnt == MAX_CLK_COUNT) begin
            clk_cnt <= ZERO_CLK_COUNT;
            clk_div <= 0;
            clk_div <= ~clk_div;
        end else begin
            clk_cnt <= clk_cnt + 1;
        end
    end

    /* State Machine */
    always @(posedge clk_div or posedge rst_btn) begin
        if (rst_btn == BTN_PRESSED) begin
            state <= STATE_IDLE;
        end else begin
            case (state)
                STATE_IDLE: begin
                    if (go_btn == BTN_PRESSED) begin
                        state <= STATE_COUNTING;
                    end
                    done_sig <= 0;
                end
                STATE_COUNTING: begin
                    if (led == MAX_LED_COUNT) begin
                        done_sig <= 1;
                        state <= STATE_IDLE;
                    end
                end
                default: state <= STATE_IDLE;
            endcase
        end
    end

    /* LED control */
    always @(posedge clk_div or posedge rst_btn) begin
        if (rst_btn == BTN_PRESSED) begin
            led <= ZERO_LED_COUNT;
        end else begin
            if (state == STATE_COUNTING) begin
                led <= led + 1;
            end else begin
                led <= ZERO_LED_COUNT;
            end
        end
    end
endmodule
