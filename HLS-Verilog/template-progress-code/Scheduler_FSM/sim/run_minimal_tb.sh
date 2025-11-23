#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

g++ -std=c++17 -Wall ../Scheduler_FSM.cpp Scheduler_tb_minimal.cpp -o sim_outputs/scheduler_tb_minimal
./sim_outputs/scheduler_tb_minimal
