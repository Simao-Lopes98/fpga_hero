/*
Debounce Counter module - Implements debounced button input with counter
*/

module debounce (
    input clk,
    input btn,
    output reg dbc
);

/* Local params */
localparam  STATE_NOT_PRESSED   = 2'b00;
localparam  STATE_DEBOUNCE_P    = 2'b01;
localparam  STATE_PRESSED       = 2'b10;
localparam  STATE_DEBOUNCE_NP   = 2'b11;

localparam  BTN_PRESSED         = 1'b1;
localparam  BTN_NOT_PRESSED     = 1'b0;

localparam  DB_COUNTER_ZERO     = 24'd0;
parameter   DB_COUNTER_MAX      = 24'd1000000;
parameter   DB_COUNTER_SIZE     = 24;

/* Internal logic regs */
reg [2:0] state;
reg [DB_COUNTER_SIZE:0] db_counter;

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
        STATE_NOT_PRESSED:  dbc <= BTN_NOT_PRESSED;
        STATE_DEBOUNCE_P:   dbc <= BTN_NOT_PRESSED;
        STATE_PRESSED:      dbc <= BTN_PRESSED;
        STATE_DEBOUNCE_NP:  dbc <= BTN_PRESSED;
        default:            dbc <= BTN_NOT_PRESSED;
    endcase
end
    
endmodule
