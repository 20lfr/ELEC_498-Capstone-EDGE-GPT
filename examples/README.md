# Kria PS-PL Custom Application Development Flow

This repository provides a foundational template and example for developing, deploying, and testing **custom hardware logic (PL)** and **Linux user-space software (PS)** on a **Xilinx Kria System-on-Module (SoM)**.

The overarching theme is establishing a robust **Processing System (PS) to Programmable Logic (PL) communication channel** using standard Xilinx tools (Vivado and Vitis) and the Kria's Accelerated Application Overlay infrastructure (`xmutil`).

---

## Core Components and Goal

1.  **Hardware Design (`axi-stream-test-hw/`):** Defines the custom logic in the PL and the necessary interfaces (like AXI DMA) to communicate with the PS.
2.  **Software Application (`axi-stream-test-sw/`):** Contains the C/C++ program that runs on the Kria's Linux OS (PS) to control, configure, and interact with the custom hardware.

### Example: AXI-Stream Loopback Test

The files within this repository demonstrate a **PS-to-PL data transfer test** using the **AXI Direct Memory Access (DMA)** IP core. The goal is to verify data integrity by having the DMA stream data from PS memory to a simple **PL loopback module**, which then streams the data back to another PS memory location.

---

## Build and Deployment Summary

The build process involves generating custom hardware files and cross-compiling the software for the Kria's AArch64 architecture.

### 1. Build Prerequisites

* **Xilinx Tools:** Vivado and Vitis (used for platform and application creation).
* **Cross-Compiler:** AArch64 Linux GCC/G++ (e.g., `gcc-11-aarch64-linux-gnu`).
* **Sysroot:** Kria Ubuntu sysroot file system for cross-compiling the user-space application.

### 2. Hardware Flow (Vivado)

1.  **Design:** Build the custom logic and integrate it with the Zynq MPSoC block design (e.g., adding an AXI DMA).
2.  **Export:** Generate the bitstream and export the hardware as an **.xsa** file.
3.  **Overlay:** Use the included `overlay_generator.sh` script to convert the `.xsa` into the Kria deployment files: **`.dtbo`**, **`.bin`**, and **`shell.json`**.

### 3. Software Flow (Vitis)

1.  **Platform:** Create a Vitis platform project using the `.xsa` file.
2.  **Application Setup:** Create a Vitis Application Project targeting the **Linux domain**, configuring it to use the downloaded **sysroot** and the AArch64 cross-compiler.
3.  **Build:** Compile the application to produce the **.elf** executable.

### 4. Deployment to Kria

1.  **Overlay Installation:** Transfer the hardware files (`.dtbo`, `.bin`, `shell.json`) to the Kria and install them using the `sudo xmutil loadapp <app_name>` command.
2.  **Application Execution:** Transfer the application **.elf** file and run it on the Kria to execute the custom hardware test.
