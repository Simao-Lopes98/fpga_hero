---
name: verilog-review
description: Review Verilog/FPGA code in this repo for correctness, synthesizability, and ICEStick/APIO conventions. Use when asked to review Verilog, check a module, audit a .v file, or before building/uploading a design. Covers RTL bugs (latches, blocking/non-blocking misuse, sensitivity lists, resets, clock domains), iCE40HX1K resource fit, .pcf pin correctness, and repo style (snake_case, /* */ comments, active-low buttons).
---

# Verilog Code Review

Review Verilog HDL for this learning repo targeting the **Lattice iCE40HX1K** on the **ICEStick** board, built with **APIO**.

## Scope

Default to reviewing the uncommitted diff (`git diff`) plus any `.v`/`.pcf` files the user names. If nothing is staged/changed, ask which project directory (`NN_projectname/`) to review. Read the module's submodule files and `.pcf` too — bugs often live at instantiation/pin boundaries, not inside one file.

This is a **learning** repo: explain *why* each finding is a problem and the underlying concept, don't just hand back corrected code. Lead with teaching.

## Review checklist

Work through these categories. Report findings grouped by severity: **Bugs** (wrong/unsynthesizable behavior), **Risks** (works in sim, may fail in hardware), **Style** (repo conventions), **Suggestions**.

### 1. Combinational vs. sequential logic
- **Unintended latches**: any `always @(*)` / combinational block where a `reg` isn't assigned on every path (missing `else`, incomplete `case` without `default`) infers a latch. Flag it.
- **Blocking vs. non-blocking**: sequential `always @(posedge clk)` blocks must use `<=`; combinational blocks use `=`. Mixing them is a classic bug.
- **Sensitivity lists**: combinational blocks should be `@(*)`; flag hand-written lists that miss a signal.

### 2. Clocking & reset
- **Single clock domain per always block**: assigning the same `reg` from two different clock edges (e.g. one block on `posedge clk`, another on `posedge clk_div`) creates a multi-driver/CDC hazard. In `08_counter_2` the FSM runs on `clk` while LED updates run on `clk_div` — check that signals crossing between them are sampled safely.
- **Reset polarity & style**: this repo treats buttons as **active-low** (`assign btn = ~pmod[0];`) and uses async reset (`always @(posedge clk or posedge rst)`). Verify the reset branch is first in the block and resets all state.
- **Clock dividers**: derived clocks (e.g. `clock_div` counting to `MAX_COUNT`) used as a clock are acceptable here but note they're gated clocks, not ideal; confirm the divider actually toggles an output reg rather than producing a glitchy combinational clock.

### 3. Width & literal correctness
- Bit-width mismatches in assignments, comparisons, and port connections.
- Unsized literals (`'b1`, `'b1010`) — confirm width matches the target reg; prefer sized literals (`4'b1010`) for clarity.
- Off-by-one in counter terminal values (`MAX_COUNT = 3000000 - 1`) and LED min/max bounds.
- `output reg` vs `output wire`: outputs driven in an `always` block must be declared `reg`.

### 4. Module structure & instantiation
- Named port connections (`.clk(clk)`) — flag positional connections as error-prone.
- `defparam` vs parameter override: this repo uses `defparam clk_div.MAX_COUNT = ...`; note the modern `#(.MAX_COUNT(...))` form as a suggestion.
- The top module name **must** match `top-module` in `apio.ini`. Verify.
- Unconnected/floating outputs, undriven wires, signals declared but unused.

### 5. .pcf / board fit
- Every top-level port has a `set_io` line; pin numbers match the ICEStick: **clk=21**, **LEDs=99/98/97/96/95**, **PMOD≈78/79**.
- Inputs from buttons use `set_io -pullup yes` (buttons are active-low).
- iCE40HX1K is small (1280 LUTs, no hardware multiplier). Flag wide multipliers, large memories, or big counters that may not fit or will infer expensive logic.

### 6. Repo conventions
- Block comments use `/* */` (not `//`).
- Identifiers are `snake_case`.
- Testbenches named `*_tb.v`; check `$dumpvars`/`$finish` present so `apio sim` produces a VCD.

## Verify against the toolchain

When practical, run `apio build` in the project directory and report synthesis warnings (yosys flags inferred latches and width mismatches). For simulation-checkable logic, suggest or run `apio sim`. Treat yosys/nextpnr warnings as review findings, not noise.

## Output format

1. One-line summary (e.g. "2 bugs, 1 risk, 3 style notes").
2. Findings grouped by severity, each with: `file:line`, what's wrong, *why it matters* (the concept), and a suggested fix.
3. If you ran `apio build`, include relevant warnings.
