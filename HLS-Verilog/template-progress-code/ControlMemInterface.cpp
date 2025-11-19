#include "ControlMemInterface.hpp"

namespace {

template <typename T>
T mask_allowed(T value, T allowed) {
    return value & allowed;
}

} // namespace

uint32_t ctrl_read(const ControlMemSpace &mem, ControlReg reg) {
    switch (reg) {
        case ControlReg::DMA_LEN_TILE:      return mem.dma_len_tile;
        case ControlReg::NUM_LAYERS:        return mem.num_layers;
        case ControlReg::NUM_HEADS:         return mem.num_heads;
        case ControlReg::TILE_SIZE:         return mem.tile_size;
        case ControlReg::LAYER_STRIDE:      return mem.layer_stride;
        case ControlReg::HEAD_STRIDE:       return mem.head_stride;
        case ControlReg::TILE_STRIDE:       return mem.tile_stride;
        case ControlReg::WQ_BASE_ADDR:      return mem.wq_base_addr;
        case ControlReg::WK_BASE_ADDR:      return mem.wk_base_addr;
        case ControlReg::WV_BASE_ADDR:      return mem.wv_base_addr;
        case ControlReg::WO_BASE_ADDR:      return mem.wo_base_addr;
        case ControlReg::W1_BASE_ADDR:      return mem.w1_base_addr;
        case ControlReg::W2_BASE_ADDR:      return mem.w2_base_addr;
        case ControlReg::K_CACHE_ADDR:      return mem.k_cache_addr;
        case ControlReg::V_CACHE_ADDR:      return mem.v_cache_addr;
        case ControlReg::SCALE_Q:           return mem.scale_q;
        case ControlReg::ZERO_POINT_Q:      return mem.zero_point_q;
        case ControlReg::SCALE_K:           return mem.scale_k;
        case ControlReg::ZERO_POINT_K:      return mem.zero_point_k;
        case ControlReg::SCALE_V:           return mem.scale_v;
        case ControlReg::ZERO_POINT_V:      return mem.zero_point_v;
        case ControlReg::CONTROL:           return mem.control;
        case ControlReg::IRQ_ENABLE:        return mem.irq_enable;
        case ControlReg::IRQ_STATUS:        return mem.irq_status;
        case ControlReg::LAYER_INDEX:       return mem.layer_index;
    }
    return 0;
}

void ctrl_write(ControlMemSpace &mem, ControlReg reg, uint32_t value) {
    switch (reg) {
        case ControlReg::DMA_LEN_TILE:  mem.dma_len_tile = value;   break;
        case ControlReg::NUM_LAYERS:    mem.num_layers = value;     break;
        case ControlReg::NUM_HEADS:     mem.num_heads = value;      break;
        case ControlReg::TILE_SIZE:     mem.tile_size = value;      break;
        case ControlReg::LAYER_STRIDE:  mem.layer_stride = value;   break;
        case ControlReg::HEAD_STRIDE:   mem.head_stride = value;    break;
        case ControlReg::TILE_STRIDE:   mem.tile_stride = value;    break;
        case ControlReg::WQ_BASE_ADDR:  mem.wq_base_addr = value;   break;
        case ControlReg::WK_BASE_ADDR:  mem.wk_base_addr = value;   break;
        case ControlReg::WV_BASE_ADDR:  mem.wv_base_addr = value;   break;
        case ControlReg::WO_BASE_ADDR:  mem.wo_base_addr = value;   break;
        case ControlReg::W1_BASE_ADDR:  mem.w1_base_addr = value;   break;
        case ControlReg::W2_BASE_ADDR:  mem.w2_base_addr = value;   break;
        case ControlReg::K_CACHE_ADDR:  mem.k_cache_addr = value;   break;
        case ControlReg::V_CACHE_ADDR:  mem.v_cache_addr = value;   break;
        case ControlReg::SCALE_Q:       mem.scale_q = value;        break;
        case ControlReg::ZERO_POINT_Q:  mem.zero_point_q = value;   break;
        case ControlReg::SCALE_K:       mem.scale_k = value;        break;
        case ControlReg::ZERO_POINT_K:  mem.zero_point_k = value;   break;
        case ControlReg::SCALE_V:       mem.scale_v = value;        break;
        case ControlReg::ZERO_POINT_V:  mem.zero_point_v = value;   break;
        case ControlReg::CONTROL:       mem.control = value;        break;
        case ControlReg::IRQ_ENABLE:    mem.irq_enable = value;     break;
        case ControlReg::IRQ_STATUS:    mem.irq_status = value;     break;
            
        case ControlReg::LAYER_INDEX:   mem.layer_index = value;    break;
    }
}
