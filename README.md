# FPGA to HERO
A progressive Verilog learning repository for FPGA development on the **Lattice iCE40HX1K** using the **ICEStick Evaluation Board**. The long-term goal is to eventually create a soft RISC-V core.

## Project Structure

### Learning Modules (Progressive Complexity)
- **00_led_example/** - Basic LED blink and sequential control
- **01_and_gate/** - Combinational logic gates
- **02_adder/** - Arithmetic circuits
- **03_counter/** - Sequential logic with clock prescaling (12 MHz → 1 Hz)
- **04_fsm_moore/** - Moore Finite State Machines

## APIO - Build & Synthesis Tool

Using APIO to build, synthesize, test, and upload designs.

### Installation
Follow [Getting Started](https://fpgawars.github.io/apio/docs/installing-apio-cli/#install-using-a-file-bundle_2)

### Basic Commands
```bash
apio create -b icestick    # Initialize new project
apio build                 # Synthesize design
apio sim                   # Run simulation
apio upload                # Program FPGA board
apio                       # View full help
```
## AI Agent

If using an AI copilot, see **ai_OS/HANDOVER.md** for comprehensive guidance on:
- Creating new projects
- Verilog design help
- Design patterns and best practices
- Board-specific configurations

### Creating New Projects

**See ai_OS/HANDOVER.md for detailed workflow.** Quick summary:

1. Create folder: `NN_projectname/`
2. Add `.pcf` file (pin constraints)
3. Add `.v` file (Verilog module)
4. Add `.gitignore` (ignore `_build` and `.DS_Store`)
5. Run `apio create -b icestick`
6. Edit `apio.ini` - change `top-module = main` to your module name

## Documentation & Resources
- **docs/icestickusermanual.md** - ICEStick user manual (converted from PDF)
- **docs/iCE40LPHXFamilyDataSheet.md** - FPGA datasheet (converted from PDF)
- **ai_OS/template_project/** - Reference structure for new projects
- **ai_OS/HANDOVER.md** - Comprehensive guide for AI agents and new project creation

![Icestick Pinout](docs/icestick_pinnout.png)


## References

- [Introduction to FPGA YouTube Series](https://www.youtube.com/watch?v=lLg1AgA2Xoo&list=PLEBQazB0HUyT1WmMONxRZn9NmQ_9CIKhb)

## WSL Configuration

If using WSL, configure USB passthrough:
https://learn.microsoft.com/en-us/windows/wsl/connect-usb