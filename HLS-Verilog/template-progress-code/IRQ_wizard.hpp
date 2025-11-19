#pragma once

#include "ControlMemInterface.hpp"

// Lightweight helper that models the IRQ wizard logic around the shared control
// memory space. Keeps the register manipulation separated from the scheduler.
void irq_wizard(ControlMemSpace &mem, bool dma_done, bool infer_done, bool error, bool &irq_ps);
