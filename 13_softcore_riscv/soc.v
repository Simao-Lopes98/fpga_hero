/*
soc module - a minimal soft RISC-V core running on the ICEStick
*/


module soc (
    input           clk,
    input           reset,
    input           rx,

    output  [4:0]   led,
    output          tx
);

    /* ---------------------------------------------------------------
       CLOCK / RESET
       reset_p is the active-high, internal version of the (active-low)
       board reset input, used to drive the FSM's async reset.
    --------------------------------------------------------------- */
    wire reset_p;
    assign reset_p = ~reset;

    // Not used for now
    assign tx = 0;

    reg [7:0] PC;

    /* ---------------------------------------------------------------
       INSTRUCTION DECODER
       Splits the current instruction into opcode class (isXXX wires),
       register indices, funct3/funct7 selectors and the 5 immediate
       formats. See page 130 on docs/riscv-spec-20191213.pdf.
    --------------------------------------------------------------- */
    reg [31:0] instr;

    // Here we decode the opcode bits 6-0. i.e. which opt is being asked
    wire isALUreg  =  (instr[6:0] == 7'b0110011); // rd <- rs1 OP rs2
    wire isALUimm  =  (instr[6:0] == 7'b0010011); // rd <- rs1 OP Iimm
    wire isBranch  =  (instr[6:0] == 7'b1100011); // if(rs1 OP rs2) PC<-PC+Bimm
    wire isJALR    =  (instr[6:0] == 7'b1100111); // rd <- PC+4; PC<-rs1+Iimm
    wire isJAL     =  (instr[6:0] == 7'b1101111); // rd <- PC+4; PC<-PC+Jimm
    wire isAUIPC   =  (instr[6:0] == 7'b0010111); // rd <- PC + Uimm
    wire isLUI     =  (instr[6:0] == 7'b0110111); // rd <- Uimm
    wire isLoad    =  (instr[6:0] == 7'b0000011); // rd <- mem[rs1+Iimm]
    wire isStore   =  (instr[6:0] == 7'b0100011); // mem[rs1+Simm] <- rs2
    wire isSYSTEM  =  (instr[6:0] == 7'b1110011); // special

    // Here we aquire the arguments for each instruction. 
    // For all the instruction types, rs1, rs2 and rd are set on bits 19 to 15, 24 to 20 and 11 to 7 respectivelly
    wire [4:0] rs1Id = instr[19:15];
    wire [4:0] rs2Id = instr[24:20];
    wire [4:0] rdId  = instr[11:7];

    // For all 10 R-type instructions one needs a way to destinguish them. 
    // funct3 and funct7 are defined in the ISA for this porpose.
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];

    // For instructions that have immediate, a constant ins 'baked' into the instruction itself
    // In these cases, each instruction carry the immediate on a different place
    wire [31:0] Uimm = {    instr[31],   instr[30:12], {12{1'b0}}};
    wire [31:0] Iimm = {{21{instr[31]}}, instr[30:20]};
    wire [31:0] Simm = {{21{instr[31]}}, instr[30:25],instr[11:7]};
    wire [31:0] Bimm = {{20{instr[31]}}, instr[7],instr[30:25],instr[11:8],1'b0};
    wire [31:0] Jimm = {{12{instr[31]}}, instr[19:12],instr[20],instr[30:21],1'b0};


    /* ---------------------------------------------------------------
       INSTRUCTION MEMORY
       Test program hardcoded at init time; fetched one word per
       FETCH_INSTR_STATE cycle, indexed by PC.
    --------------------------------------------------------------- */
    // memory buffer with the instructions
    reg [31:0] mem [0:8];
    initial begin
        PC = 0;

        instr <= 32'b0000000_00000_00000_000_00000_0110011; // NOP
        
        // add x1, x0, x0
        //                    rs2   rs1  add  rd  ALUREG
        mem[0] = 32'b0000000_00000_00000_000_00001_0110011;
        // addi x1, x1, 1
        //             imm         rs1  add  rd   ALUIMM
        mem[1] = 32'b000000000001_00001_000_00001_0010011;
        // addi x1, x1, 1
        //             imm         rs1  add  rd   ALUIMM
        mem[2] = 32'b000000000001_00001_000_00001_0010011;
        // addi x1, x1, 1
        //             imm         rs1  add  rd   ALUIMM
        mem[3] = 32'b000000000001_00001_000_00001_0010011;
        // addi x1, x1, 1
        //             imm         rs1  add  rd   ALUIMM
        mem[4] = 32'b000000000001_00001_000_00001_0010011;
        // lw x2,0(x1)
        //             imm         rs1   w   rd   LOAD
        mem[5] = 32'b000000000000_00001_010_00010_0000011;
        // sw x2,0(x1)
        //             imm   rs2   rs1   w   imm  STORE
        mem[6] = 32'b000000_00010_00001_010_00000_0100011;
        
        // ebreak
        //                                        SYSTEM
        mem[7] = 32'b000000000001_00000_000_00000_1110011;
    end


    /* ---------------------------------------------------------------
       REGISTER BANK
       32 general-purpose registers. rs1/rs2 are latched copies read
       out during FETCH_REG_STATE; writeback happens below, gated by
       writeBackEn (x0 is never written).
    --------------------------------------------------------------- */
    reg [31:0]  regBank [0:31];
    reg [31:0]  rs1;
    reg [31:0]  rs2;
    wire [31:0] writeDataBack;
    wire        writeBackEn;

    /* ---------------------------------------------------------------
       FETCH / DECODE / EXECUTE FSM
       Cycles through: fetch instr from mem -> read rs1/rs2 from the
       register bank -> execute (ALU runs combinationally, PC advances).
    --------------------------------------------------------------- */
    // FSM states
    localparam FETCH_INSTR_STATE    = 2'b00;
    localparam FETCH_REG_STATE      = 2'b01;
    localparam EXECUTE_STATE        = 2'b10;
    reg [1:0] state;

    always @(posedge clk or posedge reset_p) begin
        if (reset_p == 1) begin
            state <= FETCH_INSTR_STATE;
        end
        case (state)
            FETCH_INSTR_STATE: begin
                instr <= mem[PC];
                state <= FETCH_REG_STATE;
            end
            FETCH_REG_STATE: begin
                rs1 <= regBank[rs1Id];
                rs2 <= regBank[rs2Id];
                state <= EXECUTE_STATE;
            end
            EXECUTE_STATE: begin
                PC <= PC + 1;
                state <= FETCH_INSTR_STATE;
            end
            default: state <= FETCH_INSTR_STATE;
        endcase
    end

    /* ---------------------------------------------------------------
       REGISTER WRITEBACK
       Commits the ALU result to rd on the cycle after EXECUTE_STATE,
       whenever the current instruction is one that writes a register.
    --------------------------------------------------------------- */
    always @(posedge clk) begin
        if (writeBackEn && rdId != 0) begin
            regBank[rdId] <= writeDataBack;
        end
    end

    /* ---------------------------------------------------------------
       ALU (ARITHMETIC LOGIC UNIT)
       Combinationally computes aluOut from aluIn1/aluIn2 based on
       funct3 (and funct7 for ADD/SUB and shift-type selection).
    --------------------------------------------------------------- */
    // ALU
    wire [31:0] aluIn1 = rs1;
    // Depending on the instr type, aluIn2 can assume rs2 or immideate value
    wire [31:0] aluIn2 = isALUreg ? rs2 : Iimm;
    reg  [31:0] aluOut;
    wire [4:0] shamt = isALUreg ? rs2[4:0] : instr[24:20]; // shift amount
    /*
    3'b000 	ADD or SUB
    3'b001 	left shift
    3'b010 	signed comparison (<)
    3'b011 	unsigned comparison (<)
    3'b100 	XOR
    3'b101 	logical right shift or arithmetic right shift
    3'b110 	OR
    3'b111 	AND
    */
    always @(*) begin
        case(funct3)
            3'b000: aluOut = (funct7[5] & instr[5]) ? 
                                (aluIn1-aluIn2) : (aluIn1+aluIn2);
            3'b001: aluOut = aluIn1 << shamt;
            3'b010: aluOut = ($signed(aluIn1) < $signed(aluIn2));
            3'b011: aluOut = (aluIn1 < aluIn2);
            3'b100: aluOut = (aluIn1 ^ aluIn2);
            3'b101: aluOut = funct7[5] ? ($signed(aluIn1) >>> shamt) : 
                                (aluIn1 >> shamt);
            3'b110: aluOut = (aluIn1 | aluIn2);
            3'b111: aluOut = (aluIn1 & aluIn2);
            default: aluOut = 0;
        endcase
    end
    assign writeDataBack    = aluOut;
    assign writeBackEn      = (state == EXECUTE_STATE && (isALUreg || isALUimm));

    /* ---------------------------------------------------------------
       DEBUG LED OUTPUT
       All 5 LEDs lit = halted on SYSTEM/ebreak. Otherwise: PC[0] as a
       fetch heartbeat, plus 4 bits showing the decoded instr type.
    --------------------------------------------------------------- */
    assign led = isSYSTEM ? 31 : {PC[0],isALUreg,isALUimm,isStore,isLoad};

endmodule
