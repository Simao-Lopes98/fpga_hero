/*
Debounce Counter module - Implements debounced button input with counter
*/


module debounce_counter (
    input               clk,
    input      [1:0]    pmod,
    output reg [4:0]    led
);


wire count_btn;
wire reset_btn;

/* Invert logic */
assign count_btn = ~pmod[0];
assign reset_btn = ~pmod[1];

/* Continous logic regs */
reg db_count;
reg db_reset;

debounce_btn debounce_btn_count (
    .btn (count_btn),
    .clk (clk),
    .dbc_btn (db_count)
);
debounce_btn debounce_btn_reset (
    .btn (reset_btn),
    .clk (clk),
    .dbc_btn (db_reset)
);

    always @(posedge db_count or posedge db_reset) begin
        if (db_reset == 1'b1) begin
            led <= 4'b0000;
        end else begin
            led <= led + 1'b1;
        end
    end

endmodule


module debounce_btn (
    input btn,
    input clk,
    output reg dbc_btn
);

/* Local params */
localparam  STATE_NOT_PRESSED   = 2'b00;
localparam  STATE_DEBOUNCE_P    = 2'b01;
localparam  STATE_PRESSED       = 2'b10;
localparam  STATE_DEBOUNCE_NP   = 2'b11;

localparam  BTN_PRESSED         = 1'b1;
localparam  BTN_NOT_PRESSED     = 1'b0;

localparam  DB_COUNTER_ZERO     = 24'd0;
localparam  DB_COUNTER_MAX      = 24'd1000000;

/* Internal logic regs */
reg [2:0] state;
reg [24:0] db_counter;

always @(posedge clk) begin
    case (state)
        STATE_NOT_PRESSED: begin
            if (btn == BTN_PRESSED) begin
                state <= STATE_DEBOUNCE_P;
                db_counter <= DB_COUNTER_ZERO;
            end
        end
        STATE_DEBOUNCE_P: begin
            if (btn == BTN_PRESSED) begin
                db_counter <= db_counter + 1;
            end else begin
                db_counter <= DB_COUNTER_ZERO;
            end
            
            if (db_counter == DB_COUNTER_MAX) begin
                state <= STATE_PRESSED;
            end
        end
        STATE_PRESSED: begin
            if (btn == BTN_NOT_PRESSED) begin
                state <= STATE_NOT_PRESSED;
                db_counter <= DB_COUNTER_ZERO;
            end
        end
        STATE_DEBOUNCE_NP: begin
            if (btn == BTN_NOT_PRESSED) begin
                db_counter <= db_counter + 1;
            end else begin
                db_counter <= DB_COUNTER_ZERO;
            end
            
            if (db_counter == DB_COUNTER_MAX) begin
                state <= STATE_NOT_PRESSED;
            end
        end
        default:        state <= STATE_NOT_PRESSED;
    endcase
end

always @(posedge clk) begin
    case (state)
        STATE_NOT_PRESSED:  dbc_btn <= BTN_NOT_PRESSED;
        STATE_DEBOUNCE_P:   dbc_btn <= BTN_NOT_PRESSED;
        STATE_PRESSED:      dbc_btn <= BTN_PRESSED;
        STATE_DEBOUNCE_NP:  dbc_btn <= BTN_PRESSED;
        default:            dbc_btn <= BTN_NOT_PRESSED;
    endcase
end
    
endmodule
