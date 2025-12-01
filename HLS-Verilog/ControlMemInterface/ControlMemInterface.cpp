#include "ControlMemInterface.hpp"


uint32_t ctrl_read(const ControlMemSpace &mem, ControlReg reg) {
    switch (reg) {
        case ControlReg::CONTROL:        return mem.control;
        case ControlReg::LAYER_INDEX:    return mem.layer_index;
        case ControlReg::STATUS:         return mem.status;
        case ControlReg::IRQ_STATUS:     return mem.irq_status;
        case ControlReg::IRQ_ENABLE:     return mem.irq_enable;

        case ControlReg::DMA_LAYER_LEN:  return mem.dma_layer_len;
        case ControlReg::DMA_HEAD_LEN:   return mem.dma_head_len;
        case ControlReg::DMA_TILE_LEN:   return mem.dma_tile_len;

        case ControlReg::LAYER_STRIDE:   return mem.layer_stride;
        case ControlReg::HEAD_STRIDE:    return mem.head_stride;
        case ControlReg::TILE_STRIDE:    return mem.tile_stride;

        case ControlReg::WQ_BASE_ADDR:   return mem.wq_base_addr;
        case ControlReg::WK_BASE_ADDR:   return mem.wk_base_addr;
        case ControlReg::WV_BASE_ADDR:   return mem.wv_base_addr;
        case ControlReg::WO_BASE_ADDR:   return mem.wo_base_addr;
        case ControlReg::W1_BASE_ADDR:   return mem.w1_base_addr;
        case ControlReg::W2_BASE_ADDR:   return mem.w2_base_addr;

        case ControlReg::K_CACHE_ADDR:   return mem.k_cache_addr;
        case ControlReg::V_CACHE_ADDR:   return mem.v_cache_addr;

        case ControlReg::LOGIT_SCALE_QV: return mem.logit_scale_qv;
        case ControlReg::SCALE_Q:        return mem.scale_q;
        case ControlReg::ZERO_POINT_Q:   return mem.zero_point_q;
        case ControlReg::SCALE_K:        return mem.scale_k;
        case ControlReg::ZERO_POINT_K:   return mem.zero_point_k;
        case ControlReg::SCALE_V:        return mem.scale_v;
        case ControlReg::ZERO_POINT_V:   return mem.zero_point_v;

        case ControlReg::RESERVED_DEBUG: return mem.reserved_debug;
    }
    return 0;
}

void ctrl_write(ControlMemSpace &mem, ControlReg reg, uint32_t value) {
    switch (reg) {
        case ControlReg::CONTROL:        mem.control = value;       break;
        case ControlReg::LAYER_INDEX:    mem.layer_index = value;   break;
        case ControlReg::STATUS:         mem.status = value;        break;
        case ControlReg::IRQ_STATUS:     mem.irq_status = value;    break;
        case ControlReg::IRQ_ENABLE:     mem.irq_enable = value;    break;

        case ControlReg::DMA_LAYER_LEN:  mem.dma_layer_len = value; break;
        case ControlReg::DMA_HEAD_LEN:   mem.dma_head_len = value;  break;
        case ControlReg::DMA_TILE_LEN:   mem.dma_tile_len = value;  break;

        case ControlReg::LAYER_STRIDE:   mem.layer_stride = value;  break;
        case ControlReg::HEAD_STRIDE:    mem.head_stride = value;   break;
        case ControlReg::TILE_STRIDE:    mem.tile_stride = value;   break;

        case ControlReg::WQ_BASE_ADDR:   mem.wq_base_addr = value;  break;
        case ControlReg::WK_BASE_ADDR:   mem.wk_base_addr = value;  break;
        case ControlReg::WV_BASE_ADDR:   mem.wv_base_addr = value;  break;
        case ControlReg::WO_BASE_ADDR:   mem.wo_base_addr = value;  break;
        case ControlReg::W1_BASE_ADDR:   mem.w1_base_addr = value;  break;
        case ControlReg::W2_BASE_ADDR:   mem.w2_base_addr = value;  break;

        case ControlReg::K_CACHE_ADDR:   mem.k_cache_addr = value;  break;
        case ControlReg::V_CACHE_ADDR:   mem.v_cache_addr = value;  break;

        case ControlReg::LOGIT_SCALE_QV: mem.logit_scale_qv = value;break;
        case ControlReg::SCALE_Q:        mem.scale_q = value;       break;
        case ControlReg::ZERO_POINT_Q:   mem.zero_point_q = value;  break;
        case ControlReg::SCALE_K:        mem.scale_k = value;       break;
        case ControlReg::ZERO_POINT_K:   mem.zero_point_k = value;  break;
        case ControlReg::SCALE_V:        mem.scale_v = value;       break;
        case ControlReg::ZERO_POINT_V:   mem.zero_point_v = value;  break;

        case ControlReg::RESERVED_DEBUG: mem.reserved_debug = value;break;
    }
}

void init_mem_space(ControlMemSpace& mem){
    mem.control        = CTRL_RESETN_BIT;       // cntrl_reset_n | cntrl_start
    mem.layer_index    = 0;
    mem.status         = 0;
    mem.irq_status     = 0;
    mem.irq_enable     = IRQ_DMA_DONE_BIT | IRQ_INFER_DONE_BIT | IRQ_ERROR_BIT | IRQ_CLEAR_BIT; // dma_done | inference_done  | error | clear

    mem.dma_layer_len  = 0;
    mem.dma_head_len   = 0;
    mem.dma_tile_len   = 0;

    mem.layer_stride   = 0;
    mem.head_stride    = 0;
    mem.tile_stride    = 0;

    mem.wq_base_addr   = 0;
    mem.wk_base_addr   = 0;
    mem.wv_base_addr   = 0;
    mem.wo_base_addr   = 0;
    mem.w1_base_addr   = 0;
    mem.w2_base_addr   = 0;

    mem.k_cache_addr   = 0;
    mem.v_cache_addr   = 0;

    mem.logit_scale_qv = 0;
    mem.scale_q        = 0;
    mem.zero_point_q   = 0;
    mem.scale_k        = 0;
    mem.zero_point_k   = 0;
    mem.scale_v        = 0;
    mem.zero_point_v   = 0;

    mem.reserved_debug = 0;
}

void ControlMemInterface(
    ControlMemSpace &mem,               // Memory Space defined Outside of this scope
    ControlReg      address,            // Control Register Defined address
    uint32_t        data_in,            // Data In
    uint32_t        &data_out,          // Data Out

    bool            read_control,       // Read enable
    bool            write_control,      // Write enable
    
    bool            chip_enable,        // Chip enable
    bool            reset_n             // Reset enable

){

    
    if (!reset_n) init_mem_space(mem);
    if (!chip_enable) return;
    // Defaults
    data_out = 0;
    
    if (read_control){
        data_out = ctrl_read(mem, address);
    }
    else if (write_control){
        ctrl_write(mem, address, data_in);
    }
}
    
