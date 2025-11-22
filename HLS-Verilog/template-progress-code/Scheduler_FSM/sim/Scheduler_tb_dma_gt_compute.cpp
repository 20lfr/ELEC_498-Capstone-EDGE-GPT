#include "Scheduler_tb.hpp"

int main() {
    constexpr int DMA_LAT = 4;
    constexpr int COMP_LAT = 2;
    constexpr int RQ_LAT = 2;
    return run_scheduler_tb("dma_gt_compute", DMA_LAT, COMP_LAT, RQ_LAT);
}
