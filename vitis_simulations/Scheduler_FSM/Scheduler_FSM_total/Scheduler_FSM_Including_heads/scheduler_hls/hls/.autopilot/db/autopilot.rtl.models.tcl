set SynModuleInfo {
  {SRCNAME run_single_head MODELNAME run_single_head RTLNAME scheduler_hls_run_single_head}
  {SRCNAME scheduler_hls MODELNAME scheduler_hls RTLNAME scheduler_hls IS_TOP 1
    SUBMODULES {
      {MODELNAME scheduler_hls_sparsemux_9_2_32_1_1 RTLNAME scheduler_hls_sparsemux_9_2_32_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
      {MODELNAME scheduler_hls_sparsemux_9_2_8_1_1 RTLNAME scheduler_hls_sparsemux_9_2_8_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
      {MODELNAME scheduler_hls_sparsemux_9_2_1_1_1 RTLNAME scheduler_hls_sparsemux_9_2_1_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
    }
  }
}
