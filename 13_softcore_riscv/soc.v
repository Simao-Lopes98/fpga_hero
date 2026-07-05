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

    wire reset_p;
    assign reset_p = ~reset;

    // Not used for now
    assign tx = 0;

    // Instruction decoder - see page 130 on docs/riscv-spec-20191213.pdf
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

endmodule
