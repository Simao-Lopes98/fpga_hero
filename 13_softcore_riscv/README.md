# 13 — Softcore RISC-V

Notes and reference material collected while building a small RV32I soft core for
the ICEStick (iCE40HX1K). Source of truth: `docs/riscv-spec-20191213.md`
(RISC-V Unprivileged ISA, v20191213), Chapter 2.

[Follow along guide from Bruno Levy](https://github.com/BrunoLevy/learn-fpga/blob/master/FemtoRV/TUTORIALS/FROM_BLINKER_TO_RISCV/README.md)

## Roadmap

Progress against the *From Blinker to RISC-V* tutorial steps:

- [x] **Step 1 — First blinky**: LED counter (too fast to see without a divider).
- [x] **Step 2 — Slower blinky**: clock divider to slow the blink to a visible rate.
- [x] **Step 3 — Blinker loading patterns from ROM**: fetch pre-programmed words from memory sequentially.
- [x] **Step 4 — Instruction decoder**: split the 32-bit word into opcode / regs / funct / immediates.
- [x] **Step 5 — Register bank & state machine**: register file + FETCH_INSTR → FETCH_REG → EXECUTE FSM.
- [x] **Step 6 — ALU**: arithmetic/logic ops driven by funct3/funct7.
- [x] **Step 7 — Verilog assembler**: in-hardware assembler tasks (`riscv_assembly.vh`) to write test programs.
- [x] **Step 8 — Jumps**: `JAL` / `JALR`.
- [x] **Step 9 — Branches**: `BEQ`, `BNE`, `BLT`, `BGE`, `BLTU`, `BGEU`.
- [x] **Step 10 — LUI and AUIPC**: `Uimm` / `PC + Uimm`.
- [ ] **Step 11 — Memory in a separate module**: split memory out of `soc.v` into its own module.
- [ ] **Step 12 — Size optimization**: shrink the core (ALU reuse, circuit-level tricks) to fit comfortably on the HX1K.

---

## Instruction encoding variants (R / I / S / B / U / J)

These are the six **instruction encoding formats** of RV32I — the different ways
the 32 bits of an instruction get carved into fields. Every instruction is exactly
32 bits; the "type" just describes *which layout* those bits use.

The letters aren't acronyms in the usual sense — they're mnemonic labels:

| Type | Name (informal) | Used by | Has immediate? |
|------|------|---------|------|
| **R** | **R**egister | register-register ops: `ADD`, `SUB`, `SLL`, `SLT`, `XOR`, `AND`… | no — two regs in, one reg out |
| **I** | **I**mmediate | reg-immediate ops (`ADDI`, `ANDI`, shifts), **loads** (`LW`, `LB`), `JALR`, `ECALL` | 12-bit signed |
| **S** | **S**tore | stores: `SW`, `SH`, `SB` | 12-bit signed |
| **B** | **B**ranch | branches: `BEQ`, `BNE`, `BLT`, `BGE`… | 13-bit signed (PC offset, ×2) |
| **U** | **U**pper | `LUI`, `AUIPC` | 20-bit, placed in the *upper* bits |
| **J** | **J**ump | `JAL` | 21-bit signed (PC offset, ×2) |

The core distinction is **what mix of operands an instruction needs**, and the
format is designed around that:

- **R** needs `rs1`, `rs2`, `rd` and no constant → all leftover bits become
  `funct7`/`funct3` to pick the exact operation.
- **I** needs one register + a small constant → `rs2` is replaced by a 12-bit
  immediate.
- **S** needs two registers + a constant but **no destination** (it writes memory,
  not a register) → so the immediate is split into two chunks to leave `rs1`/`rs2`
  in place.
- **B** is S's twin, but the immediate encodes a branch *offset* (multiple of 2
  bytes).
- **U** needs just a big 20-bit constant + a destination.
- **J** is U's twin, but the immediate encodes a jump *offset*.

Two facts make them cheap in hardware, which is why the format matters for the
softcore:

1. **`rs1`, `rs2`, `rd` are always in the same bit positions** across all six
   formats → you can read registers before decoding finishes.
2. **The sign bit is always `inst[31]`** → sign-extension happens in parallel with
   decode.
