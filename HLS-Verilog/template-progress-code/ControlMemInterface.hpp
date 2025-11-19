#pragma once

#include <cstdint>

// ------------------------------------------------------------
// Control memory register map (AXI-Lite accessible)
// ------------------------------------------------------------
enum class ControlReg : uint32_t {
    DMA_LEN_TILE   = 0x00,
    NUM_LAYERS     = 0x04,
    NUM_HEADS      = 0x08,
    TILE_SIZE      = 0x0C,
    LAYER_STRIDE   = 0x10,
    HEAD_STRIDE    = 0x14,
    TILE_STRIDE    = 0x18,
    WQ_BASE_ADDR   = 0x1C,
    WK_BASE_ADDR   = 0x20,
    WV_BASE_ADDR   = 0x24,
    WO_BASE_ADDR   = 0x28,
    W1_BASE_ADDR   = 0x2C,
    W2_BASE_ADDR   = 0x30,
    K_CACHE_ADDR   = 0x34,
    V_CACHE_ADDR   = 0x38,
    SCALE_Q        = 0x3C,
    ZERO_POINT_Q   = 0x40,
    SCALE_K        = 0x44,
    ZERO_POINT_K   = 0x48,
    SCALE_V        = 0x4C,
    ZERO_POINT_V   = 0x50,
    CONTROL        = 0x54,
    STATUS         = 0x58,
    IRQ_ENABLE     = 0x5C,
    IRQ_STATUS     = 0x60,
    LAYER_INDEX    = 0x64
};

// CONTROL register bit definitions
constexpr uint32_t CTRL_START_BIT   = 1u << 0;
constexpr uint32_t CTRL_RESETN_BIT  = 1u << 1;

// STATUS register bit definitions
constexpr uint32_t STATUS_DONE_BIT  = 1u << 0;
constexpr uint32_t STATUS_ERROR_BIT = 1u << 1;

// IRQ register bit definitions (shared between ENABLE/STATUS)
constexpr uint32_t IRQ_INFER_DONE_BIT   = 1u << 0;
constexpr uint32_t IRQ_DMA_DONE_BIT     = 1u << 1;
constexpr uint32_t IRQ_ERROR_BIT        = 1u << 2;
constexpr uint32_t IRQ_CLEAR_BIT        = 1u << 3;

// Structure that mirrors the AXI-lite accessible registers.
struct ControlMemSpace {
    uint32_t dma_len_tile   = 0;
    uint32_t num_layers     = 0;
    uint32_t num_heads      = 0;
    uint32_t tile_size      = 0;
    uint32_t layer_stride   = 0;
    uint32_t head_stride    = 0;
    uint32_t tile_stride    = 0;
    uint32_t wq_base_addr   = 0;
    uint32_t wk_base_addr   = 0;
    uint32_t wv_base_addr   = 0;
    uint32_t wo_base_addr   = 0;
    uint32_t w1_base_addr   = 0;
    uint32_t w2_base_addr   = 0;
    uint32_t k_cache_addr   = 0;
    uint32_t v_cache_addr   = 0;
    uint32_t scale_q        = 0;
    uint32_t zero_point_q   = 0;
    uint32_t scale_k        = 0;
    uint32_t zero_point_k   = 0;
    uint32_t scale_v        = 0;
    uint32_t zero_point_v   = 0;
    uint32_t control        = CTRL_RESETN_BIT; // default reset released
    uint32_t status         = 0;
    uint32_t irq_enable     = 0;
    uint32_t irq_status     = 0;
    uint32_t layer_index    = 0;
};

// ------------------------------------------------------------
// Simple read/write helpers (usable in top.cpp or SW TB)
// ------------------------------------------------------------
uint32_t ctrl_read(const ControlMemSpace &mem, ControlReg reg);
void     ctrl_write(ControlMemSpace &mem, ControlReg reg, uint32_t value);

inline bool ctrl_start(const ControlMemSpace &mem) {
    return (mem.control & CTRL_START_BIT) != 0;
}
inline bool ctrl_reset_n(const ControlMemSpace &mem) {
    return (mem.control & CTRL_RESETN_BIT) != 0;
}

inline void ctrl_set_layer_index(ControlMemSpace &mem, uint32_t idx) {
    mem.layer_index = idx;
}

void ctrl_set_status(ControlMemSpace &mem, uint32_t status_mask, bool value);
void ctrl_raise_irq(ControlMemSpace &mem, uint32_t irq_mask);
void ctrl_clear_irq(ControlMemSpace &mem, uint32_t irq_mask);
