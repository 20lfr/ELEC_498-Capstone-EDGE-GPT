#include "Scheduler_tb.hpp"

int main() {
    constexpr int DMA_LAT = 2;
    constexpr int COMP_LAT = 4;
    constexpr int RQ_LAT = 4;
    return run_scheduler_tb("dma_lt_compute", DMA_LAT, COMP_LAT, RQ_LAT);
}
