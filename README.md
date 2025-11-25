# ELEC 498 Capstone - LiteLM

## Project Overview
**LiteLM** is an FPGA-based hardware accelerator designed to efficiently run inference for Transformer-based Large Language Models (LLMs). The project aims to offload compute-intensive operations—such as Matrix Multiplications (GEMM) and Attention mechanisms—from general-purpose processors to specialized hardware logic, enabling faster and more energy-efficient inference on edge devices.

## Architecture
The accelerator is built around a custom High-Level Synthesis (HLS) design that processes the Transformer model layer-by-layer.

## Directory Structure

*   **`HLS-Verilog/`**: Contains the core HLS source code for the hardware accelerator.
    *   `Scheduler_FSM/`: The main control logic and Finite State Machine.
    *   `ControlMemInterface/`: Interface for control memory.
    *   `IRQ_Wizard/`: Interrupt handling logic.
    *   `top.cpp`: The top-level wrapper for the HLS design.
*   **`SV_testbenches/`**: SystemVerilog testbenches for low-level hardware verification (e.g., `run_head_group_tb.sv`).
*   **`vitis_simulations/`**: Vitis-based simulation files.
*   **`vivado_simulations/`**: Vivado-based simulation files.

### Prerequisites
*   Xilinx Vitis / Vivado (2024.1 or compatible)

### Simulation
Refer to the `HLS-Verilog/README.md` for details on running C-simulations for individual modules.

# Part Number for the Kria260 Vison Dev Board: 
xck26-sfvc784-2lv
This ID is the part number used on Vitis and Vivado for the Kria260 Vision Dev Board. 
NOTE: For Vivado, you have the option to just select the Kria260 Vision Dev Board in the board selection menu.
