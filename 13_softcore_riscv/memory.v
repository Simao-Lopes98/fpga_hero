/*
memory.v

The program executed by the CPU is described here in assembly.
The CPU accesses this module to fetch its RISC-V instructions.

Whenever the CPU wants to read something, it has to drive readEn HIGH and
provide a valid memory address (memAddr). The word that was read becomes
available on memOut one clock edge later (single-cycle read latency).
*/

module memory (
    input               clk,
    input       [31:0]  memAddr,    /* Byte address of the word to read */
    input               readEn,     /* Read enable, active HIGH */

    output reg  [31:0]  memOut      /* Word read, valid one clk after readEn */
);

    /* ---------------------------------------------------------------
       STORAGE
       256 words of 32 bits = 1 KB, which is what comfortably fits in
       the iCE40HX1K block RAMs (EBR). It is inferred as block RAM
       rather than logic because the read is registered (see the
       always block below) and there is a single read port.

       MEM must be declared *before* including riscv_assembly.vh: the
       assembler tasks in that file write straight into MEM by name.
    --------------------------------------------------------------- */
    reg [31:0] MEM [0:255];

    /* ---------------------------------------------------------------
       INSTRUCTION MEMORY
       Test program hardcoded at init time; fetched one word per
       FETCH_INSTR_STATE cycle. PC is a byte address (RISC-V convention,
       needed so branch/jump immediates add to it directly), so MEM
       -- a word array -- is indexed by memAddr[31:2], i.e. the two
       lowest address bits are ignored (accesses are word aligned).

       riscv_assembly.vh supplies the ADD/ADDI/... assembler tasks used
       below to populate MEM; it must be `included from inside a module
       (see its header comment), not compiled as a standalone file. It
       also declares memPC, the assembler's write cursor: each task
       writes one word at memPC and then advances it by 4 bytes.
    --------------------------------------------------------------- */
    `include "riscv_assembly.vh"
    initial begin
        /* Address where the assembler starts emitting code */
        memPC = 0;

        LUI (x1, 32'b11111111111111111111111111111111);
        ORI (x1, x1, 32'b11111111111111111111111111111111);

        EBREAK();
        endASM();
    end

    /* ---------------------------------------------------------------
       READ PORT
       Synchronous read: on each rising clk edge, if readEn is HIGH the
       addressed word is registered onto memOut, so the CPU sees it on
       the following cycle. While readEn is LOW memOut keeps its last
       value. Reads beyond the 1 KB array are undefined (x in
       simulation) -- nothing here bounds-checks memAddr.
    --------------------------------------------------------------- */
    always @(posedge clk) begin
        if (readEn == 1'b1) begin
            memOut <= MEM [memAddr[31:2]];
        end
    end

endmodule
