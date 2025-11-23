#!/bin/bash

# ==============================================================================
# Kria KV260 Overlay Generator
# Automated script to generate .dtbo, .bin, and shell.json from .xsa
# ==============================================================================

# --- USER CONFIGURATION (EDIT THESE) ---
# 1. Path to your Xilinx settings (Check your version)
XILINX_SETTINGS="/media/tristan/external-drive/tools/Xilinx/2025.1/Vitis/settings64.sh"

# 2. Your Input XSA File
INPUT_XSA="/home/tristan/development/edge_gpt/ELEC_498-Capstone-EDGE-GPT/examples/axi-stream-test-hw/system_wrapper.xsa"

# 3. Output Directory
OUTPUT_DIR="./kria_output"

# 4. Your App Name (for folder naming on the board)
APP_NAME="my_custom_app"

# 5. Target Branch for Device Tree (Must match your Vivado version roughly)
DTG_BRANCH="xlnx_rel_v2025.1"
# ==============================================================================

set -e # Exit immediately if a command exits with a non-zero status

echo ">>> Sourcing Xilinx Environment..."
if [ -f "$XILINX_SETTINGS" ]; then
  source "$XILINX_SETTINGS"
else
  echo "ERROR: Xilinx settings not found at $XILINX_SETTINGS"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

echo ">>> Step 1: preparing Device Tree Repository..."
# We clone manually to avoid XSCT 'git-remote-https' errors
if [ ! -d "device-tree-xlnx" ]; then
  git clone https://github.com/Xilinx/device-tree-xlnx.git
  cd device-tree-xlnx
  git checkout $DTG_BRANCH
  cd ..
else
  echo "    Repo already exists, skipping clone."
fi

echo ">>> Step 2: Extracting Bitstream from XSA..."
# The XSA is a zip file. We need the .bit file inside.
unzip -o -j "$INPUT_XSA" "*.bit" -d .
BIT_FILE=$(find . -maxdepth 1 -name "*.bit" | head -n 1)
if [ -z "$BIT_FILE" ]; then
  echo "ERROR: No .bit file found inside the XSA!"
  exit 1
fi
echo "    Found bitstream: $BIT_FILE"

echo ">>> Step 3: Generating Device Tree Source (DTSI) via XSCT..."
# We write a temporary TCL script for XSCT to execute
cat <<EOT >generate_dts.tcl
hsi open_hw_design "$INPUT_XSA"
hsi set_repo_path ./device-tree-xlnx
hsi create_sw_design device-tree -os device_tree -proc psu_cortexa53_0
hsi set_property CONFIG.dt_overlay true [hsi::get_os]
hsi set_property CONFIG.dt_zocl true [hsi::get_os]
hsi generate_target -dir ./dts_output
hsi close_hw_design [hsi current_hw_design]
exit
EOT

# Run XSCT
xsct generate_dts.tcl

echo ">>> Step 4: Compiling DTBO (Fixing Include Paths)..."
# This step fixes the "fatal error: dt-bindings/.../irq.h" issue
# We use gcc -E to resolve includes pointing to the local repo
DTS_FILE="./dts_output/pl.dtsi"
INCLUDE_PATH="./device-tree-xlnx/include"

if [ ! -f "$DTS_FILE" ]; then
  echo "ERROR: XSCT failed to generate pl.dtsi"
  exit 1
fi

# Pre-process (Flatten includes)
gcc -E -nostdinc -undef -D__DTS__ -x assembler-with-cpp -I "$INCLUDE_PATH" "$DTS_FILE" -o pl.preprocessed.dtsi

# Compile to .dtbo
dtc -@ -O dtb -o pl.dtbo pl.preprocessed.dtsi
echo "    Generated: pl.dtbo"

echo ">>> Step 5: Converting Bitstream to Bin..."
# Kria Linux requires .bin, not .bit. We use bootgen.
echo "all: { [destination_device = pl] $BIT_FILE }" >bitstream.bif
bootgen -image bitstream.bif -arch zynqmp -o "$APP_NAME.bit.bin" -w
echo "    Generated: $APP_NAME.bit.bin"

echo ">>> Step 6: Creating shell.json..."
# Create the manifest for xmutil
cat <<EOT >shell.json
{
    "shell_type": "XRT_FLAT",
    "num_slots": "1",
    "dtbo": "pl.dtbo",
    "bitstream": "$APP_NAME.bit.bin"
}
EOT
echo "    Generated: shell.json"

echo "============================================================"
echo "SUCCESS! Files ready in $OUTPUT_DIR"
echo "To install on Kria:"
echo "1. Copy files: scp pl.dtbo $APP_NAME.bit.bin shell.json ubuntu@<kria-ip>:~/"
echo "2. On Kria: sudo mkdir /lib/firmware/xilinx/$APP_NAME"
echo "3. On Kria: sudo mv pl.dtbo $APP_NAME.bin shell.json /lib/firmware/xilinx/$APP_NAME/"
echo "4. On Kria: sudo xmutil unloadapp && sudo xmutil loadapp $APP_NAME"
echo "============================================================"
