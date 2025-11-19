#include "IRQ_wizard.hpp"

namespace {

constexpr uint32_t kStatusMask   = IRQ_DMA_DONE_BIT | IRQ_INFER_DONE_BIT | IRQ_ERROR_BIT | IRQ_CLEAR_BIT;
constexpr uint32_t kMaskableBits = IRQ_DMA_DONE_BIT | IRQ_INFER_DONE_BIT | IRQ_ERROR_BIT; // clear bit bypasses mask

inline bool evaluate_irq(const ControlMemSpace &mem) {
    return (mem.irq_status & (mem.irq_enable & kMaskableBits)) != 0;
}

} 


void irq_wizard(ControlMemSpace &mem, bool dma_done, bool infer_done, bool error, bool &irq_ps) {
    uint32_t &status = mem.irq_status;

    // PS wrote the clear bit; drop the status register and interrupt.
    if (status & IRQ_CLEAR_BIT) {
        status = 0;
        irq_ps = false;
        return;
    }

    if (dma_done) {
        status |= IRQ_DMA_DONE_BIT;
    }
    if (infer_done) {
        status |= IRQ_INFER_DONE_BIT;
    }
    if (error) {
        status |= IRQ_ERROR_BIT;
    }

    irq_ps = evaluate_irq(mem);
}
