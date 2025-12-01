#pragma once

#include <cstdint>

// ------------------------------------------------------------
// Control + IRQ bitfields
// ------------------------------------------------------------
constexpr uint32_t CTRL_START_BIT    = 1u << 0;
constexpr uint32_t CTRL_RESETN_BIT   = 1u << 1;

constexpr uint32_t IRQ_DMA_DONE_BIT   = 1u << 0;
constexpr uint32_t IRQ_INFER_DONE_BIT = 1u << 1;
constexpr uint32_t IRQ_ERROR_BIT      = 1u << 2;
constexpr uint32_t IRQ_CLEAR_BIT      = 1u << 3;

// ------------------------------------------------------------
// Control memory register map (AXI-Lite accessible)
// ------------------------------------------------------------
enum class ControlReg : uint32_t {
    CONTROL         = 0x00, // 0
    LAYER_INDEX     = 0x04, // 1
    STATUS          = 0x08, // 2
    IRQ_STATUS      = 0x0C, // 3
    IRQ_ENABLE      = 0x10, // 4

    DMA_LAYER_LEN   = 0x14, // 5
    DMA_HEAD_LEN    = 0x18, // 6
    DMA_TILE_LEN    = 0x1C, // 7

    LAYER_STRIDE    = 0x20, // 8
    HEAD_STRIDE     = 0x24, // 9
    TILE_STRIDE     = 0x28, // 10

    WQ_BASE_ADDR    = 0x2C, // 11
    WK_BASE_ADDR    = 0x30, // 12
    WV_BASE_ADDR    = 0x34, // 13
    WO_BASE_ADDR    = 0x38, // 14
    W1_BASE_ADDR    = 0x3C, // 15
    W2_BASE_ADDR    = 0x40, // 16

    K_CACHE_ADDR    = 0x44, // 17
    V_CACHE_ADDR    = 0x48, // 18

    LOGIT_SCALE_QV  = 0x4C, // 19
    SCALE_Q         = 0x50, // 20
    ZERO_POINT_Q    = 0x54, // 21
    SCALE_K         = 0x58, // 22
    ZERO_POINT_K    = 0x5C, // 23
    SCALE_V         = 0x60, // 24
    ZERO_POINT_V    = 0x64, // 25

    RESERVED_DEBUG  = 0x68  // 26
};

// Structure that mirrors the AXI-lite accessible registers.
struct ControlMemSpace {
    uint32_t control        = CTRL_RESETN_BIT;  // cntrl_reset | cntrl_start
    uint32_t layer_index    = 0;
    uint32_t status         = 0;
    uint32_t irq_status     = 0; // dma_done | inference_done  | error | clear
    uint32_t irq_enable     = IRQ_DMA_DONE_BIT | IRQ_INFER_DONE_BIT | IRQ_ERROR_BIT | IRQ_CLEAR_BIT; // dma_done | inference_done  | error | clear

    uint32_t dma_layer_len  = 0;
    uint32_t dma_head_len   = 0;
    uint32_t dma_tile_len   = 0;

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

    uint32_t logit_scale_qv = 0;
    uint32_t scale_q        = 0;
    uint32_t zero_point_q   = 0;
    uint32_t scale_k        = 0;
    uint32_t zero_point_k   = 0;
    uint32_t scale_v        = 0;
    uint32_t zero_point_v   = 0;

    uint32_t reserved_debug = 0;
};

// ------------------------------------------------------------
// Simple read/write helpers (usable in top.cpp or SW TB)
// ------------------------------------------------------------
uint32_t ctrl_read(const ControlMemSpace &mem, ControlReg reg);
void     ctrl_write(ControlMemSpace &mem, ControlReg reg, uint32_t value);

// Convenience helpers for top-level modules
inline bool ctrl_start(const ControlMemSpace &mem)   { return (mem.control & CTRL_START_BIT) != 0; }
inline bool ctrl_reset_n(const ControlMemSpace &mem) { return (mem.control & CTRL_RESETN_BIT) != 0; }

void init_mem_space(ControlMemSpace& mem);
void ControlMemInterface(
    ControlMemSpace &mem,               // Memory Space defined Outside of this scope
    ControlReg      address,            // Control Register Defined address
    uint32_t        data_in,            // Data In
    uint32_t        &data_out,          // Data Out

    bool            read_control,       // Read enable
    bool            write_control,      // Write enable
    
    bool            chip_enable,        // Chip enable
    bool            reset_n             // Reset enable

);
