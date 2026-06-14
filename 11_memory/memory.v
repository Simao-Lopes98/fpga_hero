/*
Memory module - learning on-chip memory (registers / block RAM) on the iCE40
*/


module memory (
    input       clk,
    input       w_en,        
    input       r_en,        
    input       [3:0] w_addr,        
    input       [3:0] r_addr,        
    input       [7:0] w_data,

    output reg  [7:0] r_data        
);
    parameter  INIT_FILE = ""; 

    localparam EN_HIGH = 'b1;

    // Declare memory
    reg [7:0] mem [0:15];

    always @(posedge clk) begin        
        if (w_en == EN_HIGH) begin
            mem [w_addr] <= w_data;
        end

        if (r_en == EN_HIGH) begin
            r_data <= mem [r_addr];
        end
    end

    /* Init memory if available */
    initial if (INIT_FILE) begin
        $readmemh(INIT_FILE, mem);
    end

endmodule
