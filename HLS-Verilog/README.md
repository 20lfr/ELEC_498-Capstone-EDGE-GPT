# HLS-Verilog directory
This directory includes each module we want to make in the hardware design. Each sub directory outlines C files and their associated C simulation testbenches. 

# ./Scheduler_FSM/
This outlines the heart of the design. The FSM times all compute, and data transfers in the design, using every other module as slaves. There are three files:
    1. Scheduler_FSM.hpp~~~~~~~~~~~~~~~~~~~~~~~~~
        Responsible for managing and hold all assumptions variables and function prototypes for this entire module.
    2. Scheduler_FSM.cpp~~~~~~~~~~~~~~~~~~~~~~~~~
        Contains the main FSM, and calls head helpers to handle parallel attention. Each stage asserts external signals to control
        the shared compute block, and data modules (AXI-stream, AXI-full, shared control memory). 
    3. Scheduler_head_helpers.cpp~~~~~~~~~~~~~~~~
        Helper functions used to model parallel computation for head groups. Uses a shared resource manager to control which heads have access to the compute block at a time. 

# ./Scheduler_FSM/C_testbenches
Each testbench included in this directory control and simulate the above files. 
    1. Scheduler_head_helpers.cpp   --> Tests ONLY Scheduler_head_helpers.cpp
    2. Scheduler_tb_minimal.cpp     --> Tests Scheduler_FSM.cpp (which includes Scheduler_head_helpers.cpp)
