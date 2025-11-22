#pragma once

int run_scheduler_tb(const char *variant_name,
                     int         dma_latency_cycles,
                     int         compute_latency_cycles,
                     int         requant_latency_cycles);
