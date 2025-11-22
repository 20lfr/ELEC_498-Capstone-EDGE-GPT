#include "Scheduler_tb.hpp"

int main() {
    constexpr int DMA_LAT = 3;
    constexpr int COMP_LAT = 3;
    constexpr int RQ_LAT = 3;
    return run_scheduler_tb("dma_eq_compute", DMA_LAT, COMP_LAT, RQ_LAT);
}
