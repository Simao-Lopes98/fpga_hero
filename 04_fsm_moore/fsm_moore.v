/*
FSM Moore module - State machine implementation
*/


module fsm_moore (
    input               clk,
    input      [1:0]    pmod,
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

    /* Max counts for clock divider and counter */
    localparam MAX_CLK_COUNT    = 24'd1500000;
    localparam MAX_LED_COUNT    = 4'hf;

    /* Internal storage for procedural */
    reg         div_clk;
    reg [1:0]   state;
    reg [23:0]  clk_cnt;

    /* Clk div */
    always @(posedge clk or posedge rst_btn) begin
        if (rst_btn == 1'b1)begin
            clk_cnt <= 24'd0;
        end else if (clk_cnt == MAX_CLK_COUNT) begin
            clk_cnt <= 24'd0;
            div_clk <= ~div_clk;
        end else begin
            clk_cnt <= clk_cnt + 1;
        end
        
    end

    /* State logic */
    always @(posedge div_clk or posedge rst_btn) begin
        if (rst_btn == 1'b1) begin
            state <= STATE_IDLE;
        end else begin
            case (state)
                STATE_IDLE: begin
                    if (go_btn == 1'b1) begin
                        state <= STATE_COUNTING;
                    end
                end

                STATE_COUNTING: begin
                    if (led == MAX_LED_COUNT) begin
                        state <= STATE_DONE;
                    end
                end

                STATE_DONE: state <= STATE_IDLE;

                default: state <= STATE_IDLE;
            endcase
        end
    end

    /* LED logic */
    always @(posedge div_clk or posedge rst_btn) begin
        if (rst_btn == 1'b1) begin
            led <= 4'h0;
        end else begin
            if (state == STATE_COUNTING) begin
                led <= led + 1;
            end else begin
                led <= 4'h0;
            end
        end
    end

    /* Output combinational logic */
    always @(*) begin
        if (state == STATE_DONE) begin
            done_sig = 1'b1;
        end else begin
            done_sig = 1'b0;
        end
    end

endmodule
