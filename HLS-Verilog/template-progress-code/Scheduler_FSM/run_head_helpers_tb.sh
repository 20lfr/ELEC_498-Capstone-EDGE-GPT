#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR"
CXX=${CXX:-g++}
CXXFLAGS="-std=c++17 -Wall -Wextra -O0"
SRC_FILES=(
  "$SRC_DIR/Scheduler_head_helpers.cpp"
  "$SRC_DIR/Scheduler_head_helpers_tb.cpp"
)
OUT="$SCRIPT_DIR/head_helpers_tb"

$CXX $CXXFLAGS "${SRC_FILES[@]}" -o "$OUT"
"$OUT"
