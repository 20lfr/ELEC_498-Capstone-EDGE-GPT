#include "ControlMemInterface.hpp"

#include <cassert>
#include <cstdlib>
#include <iostream>

namespace {

void test_reset_behavior() {
    ControlMemSpace mem{};
    mem.dma_layer_len = 123;
    mem.control = 0;
    mem.irq_enable = 0;
    mem.irq_status = 0xFFFF;

    uint32_t data_out = 0xDEADBEEF;
    ControlMemInterface(mem,
                        ControlReg::DMA_LAYER_LEN,
                        0,
                        data_out,
                        /*read_control=*/false,
                        /*write_control=*/false,
                        /*chip_enable=*/true,
                        /*reset_n=*/false);

    assert(mem.dma_layer_len == 0);
    assert(mem.control == CTRL_RESETN_BIT);
    assert(mem.irq_enable == (IRQ_DMA_DONE_BIT | IRQ_INFER_DONE_BIT | IRQ_ERROR_BIT | IRQ_CLEAR_BIT));
    assert(mem.irq_status == 0);
    assert(data_out == 0); // data_out is cleared when chip is enabled
}

void test_write_and_read() {
    ControlMemSpace mem{};
    init_mem_space(mem);
    uint32_t data_out = 0;

    ControlMemInterface(mem,
                        ControlReg::DMA_HEAD_LEN,
                        7u,
                        data_out,
                        /*read_control=*/false,
                        /*write_control=*/true,
                        /*chip_enable=*/true,
                        /*reset_n=*/true);
    assert(mem.dma_head_len == 7u);

    ControlMemInterface(mem,
                        ControlReg::DMA_HEAD_LEN,
                        0,
                        data_out,
                        /*read_control=*/true,
                        /*write_control=*/false,
                        /*chip_enable=*/true,
                        /*reset_n=*/true);
    assert(data_out == 7u);
}

void test_chip_disable_gates_access() {
    ControlMemSpace mem{};
    init_mem_space(mem);
    uint32_t data_out = 0xAA;

    ControlMemInterface(mem,
                        ControlReg::LOGIT_SCALE_QV,
                        3u,
                        data_out,
                        /*read_control=*/false,
                        /*write_control=*/true,
                        /*chip_enable=*/false,
                        /*reset_n=*/true);

    assert(mem.logit_scale_qv == 0); // write ignored
    assert(data_out == 0xAA);        // data_out untouched
}

void test_read_prioritizes_over_write() {
    ControlMemSpace mem{};
    init_mem_space(mem);
    mem.tile_stride = 10;

    uint32_t data_out = 0;
    ControlMemInterface(mem,
                        ControlReg::TILE_STRIDE,
                        99u,
                        data_out,
                        /*read_control=*/true,
                        /*write_control=*/true,
                        /*chip_enable=*/true,
                        /*reset_n=*/true);

    assert(data_out == 10u);
    assert(mem.tile_stride == 10u); // write blocked when read asserted
}

} // namespace

int main() {
    test_reset_behavior();
    test_write_and_read();
    test_chip_disable_gates_access();
    test_read_prioritizes_over_write();

    std::cout << "ControlMemInterface_tb: all tests passed\n";
    return EXIT_SUCCESS;
}
