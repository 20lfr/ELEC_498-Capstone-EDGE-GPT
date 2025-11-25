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
    IRQ_ENABLE     = 0x58,
    IRQ_STATUS     = 0x5C,
    LAYER_INDEX    = 0x60
};

// CONTROL register bit definitions
constexpr uint32_t CTRL_START_BIT   = 1u << 0;
constexpr uint32_t CTRL_RESETN_BIT  = 1u << 1;

// IRQ register bit definitions (dma_done | inference_done | error | clear)
constexpr uint32_t IRQ_DMA_DONE_BIT   = 1u << 3;
constexpr uint32_t IRQ_INFER_DONE_BIT = 1u << 2;
constexpr uint32_t IRQ_ERROR_BIT      = 1u << 1;
constexpr uint32_t IRQ_CLEAR_BIT      = 1u << 0;

// Structure that mirrors the AXI-lite accessible registers.
struct ControlMemSpace {
    uint32_t dma_len_tile   = 0; // NOTE: assumes all tiles are the same dimensions
    uint32_t num_layers     = 0;
    uint32_t num_heads      = 0;
    uint32_t tile_size      = 0; // NOTE: assumes all tiles are the same dimensions

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
                                                // LSB is furthest to the right
    uint32_t control        = CTRL_RESETN_BIT;  // cntrl_reset | cntrl_start 
    uint32_t layer_index    = 0;
    uint32_t irq_enable     = 14;               // dma_done | inference_done  | error | clear <-- bit mask default is: 14 == 1110
    uint32_t irq_status     = 0;                // dma_done | inference_done  | error | clear
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
