# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A progressive Verilog learning repository for FPGA development on the **Lattice iCE40HX1K** via the **ICEStick Evaluation Board**. Each top-level `NN_projectname/` directory is a self-contained lesson of increasing complexity (LED → gates → adder → counter → FSM → debounce → clock divider → multi-module designs). Long-term goal: a soft RISC-V core.

The repository follows the [Introduction to FPGA YouTube series](https://www.youtube.com/watch?v=lLg1AgA2Xoo&list=PLEBQazB0HUyT1WmMONxRZn9NmQ_9CIKhb).

## Build & simulate (APIO)

All commands run from **inside a project directory** (each has its own `apio.ini`):

```bash
apio build      # Synthesize design (yosys/nextpnr) → _build/
apio sim        # Run simulation; requires a *_tb.v testbench + .gtkw, opens GTKWave
apio upload      # Program the connected ICEStick over USB
apio create -b icestick   # Generate apio.ini for a NEW project (see workflow below)
```

There is no repo-wide build/test runner — operate one project directory at a time. `_build/` is generated output and git-ignored.

On WSL, USB passthrough must be configured before `apio upload` works (see README).

## Project anatomy

Each `NN_projectname/` contains:
- `*.v` — Verilog module(s). The top module name must match `top-module` in `apio.ini`.
- `*.pcf` — pin constraints mapping signals to physical ICEStick pins.
- `apio.ini` — APIO config; auto-generated, then `top-module` is hand-edited.
- `*_tb.v` / `*.gtkw` — optional testbench + GTKWave layout for `apio sim`.

Multi-module projects (e.g. `08_counter_2/`) keep submodules in separate `.v` files (`clock_div.v`, `btn_dbc.v`) and instantiate them from the top module. APIO compiles all `.v` files in the directory.

## ICEStick hardware constants

These pin assignments are fixed by the board and appear in every `.pcf`:
- **Clock**: 12 MHz oscillator on pin 21. Designs typically divide this down (e.g. a clock-divider module counting to a `MAX_COUNT` for a ~1 Hz LED tick).
- **LEDs**: 5 user LEDs on pins 99, 98, 97, 96, 95.
- **PMOD I/O**: typically pins 78, 79; declare buttons with `set_io -pullup yes`. Buttons are active-low, so designs invert: `assign btn = ~pmod[0];`.

## Conventions (enforced)

- Block comments use `/* */` format (not `//`).
- Signal/variable names are `snake_case`.
- Buttons treated active-low (pull-up + invert).

## Creating a new project — strict workflow

Reference `ai_OS/template_project/` as the canonical structure. Follow these steps **in order**:

1. Create `NN_projectname/` with the next incrementing number. Ask for the name if not given.
2. Create `projectname.pcf` (copy template; set oscillator/LED/PMOD pins).
3. Create `projectname.v` as a **module stub only — no implementation**, e.g. `module fsm_moore (input [1:0] pmod, input clk, output reg [4:0] led); endmodule`.
4. Create `.gitignore` (ignore `_build` and `.DS_Store`).
5. **Do NOT create `apio.ini` by hand.**
6. Run `cd NN_projectname && apio create -b icestick` to generate `apio.ini`.
7. Edit `apio.ini`: change `top-module = main` to `top-module = projectname` (must match the `.v` module name).

Common mistakes: creating `apio.ini` manually, forgetting to update `top-module`, mismatched module/top-module names, or adding logic in step 3.

## Skills

- **`/new-lesson`** (`.claude/skills/new-lesson/`) — scaffolds a new `NN_projectname/` lesson directory following the strict `ai_OS` workflow (`.pcf`, a stub-only `.v`, `.gitignore`, then `apio create` + `top-module` fix). Use it instead of hand-creating projects so the apio.ini gotchas are handled.
- **`/verilog-review`** (`.claude/skills/verilog-review/`) — reviews Verilog/FPGA code for this repo: RTL correctness (latches, blocking/non-blocking, sensitivity lists, reset style, clock domains), iCE40HX1K resource fit, `.pcf` pin correctness, and repo conventions. Use it before `apio build`/`apio upload`, when auditing a `.v` file, or pass a project name (e.g. `/verilog-review 06_debounce_counter`). It defaults to reviewing the `git diff` if no target is given, and can optionally run `apio build` to fold yosys/nextpnr warnings into the findings.
- **`/commit`** (`.claude/skills/commit/`) — analyzes the diff and commits with a simple, plain message (no `Co-Authored-By`/trailer lines). Warns and proposes a split when the diff spans multiple lesson directories or mixes repo-wide changes with project work, so history stays scoped per lesson.

## Working style for this repo

This is a **learning** repository. Per `ai_OS/README.md`, the intent is to teach Verilog/FPGA concepts — explain reasoning and guide rather than dumping finished implementations, unless the user explicitly asks for the full solution.

## Documentation

- `docs/icestickusermanual.md` — ICEStick user manual (Markdown, converted from PDF).
- `docs/iCE40LPHXFamilyDataSheet.md` — FPGA datasheet (Markdown).
- `docs/icestick_pinnout.png` — pinout diagram.
- Prefer the `.md` versions over the PDFs. If you need a PDF as Markdown and it isn't converted yet, use MarkItDown (see `prjs/markitdown/`) rather than scanning the PDF directly.
- `ai_OS/HANDOVER.md` and `ai_OS/README.md` — extended agent guidance and the rationale behind the project-creation workflow.
