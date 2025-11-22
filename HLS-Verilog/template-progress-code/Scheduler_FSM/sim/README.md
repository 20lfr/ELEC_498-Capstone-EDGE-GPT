# Scheduler Scheduler Testbenches

The common simulation logic lives in `Scheduler_tb.cpp` (see `run_scheduler_tb`). Three thin wrappers provide different DMA/compute timing relationships:

1. `Scheduler_tb_dma_gt_compute.cpp` &mdash; DMA takes longer than compute (4 vs. 2 cycles).
2. `Scheduler_tb_dma_lt_compute.cpp` &mdash; DMA is shorter than compute (2 vs. 4 cycles).
3. `Scheduler_tb_dma_eq_compute.cpp` &mdash; DMA and compute latencies match (3 cycles each).

Build each executable by pairing its wrapper with the shared core, for example:

```bash
g++ -std=c++17 -Wall ../Scheduler_FSM.cpp Scheduler_tb.cpp Scheduler_tb_dma_gt_compute.cpp -o scheduler_tb_dma_gt_compute
g++ -std=c++17 -Wall ../Scheduler_FSM.cpp Scheduler_tb.cpp Scheduler_tb_dma_lt_compute.cpp -o scheduler_tb_dma_lt_compute
g++ -std=c++17 -Wall ../Scheduler_FSM.cpp Scheduler_tb.cpp Scheduler_tb_dma_eq_compute.cpp -o scheduler_tb_dma_eq_compute
```

Run the desired binary to view the per-cycle schedule under the specified timing scenario.
