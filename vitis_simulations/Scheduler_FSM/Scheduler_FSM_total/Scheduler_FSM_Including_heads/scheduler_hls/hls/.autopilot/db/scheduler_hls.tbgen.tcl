set moduleName scheduler_hls
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 4
set C_modelName {scheduler_hls}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ cntrl_start uint 1 regular  }
	{ cntrl_reset_n uint 1 regular  }
	{ cntrl_layer_idx int 32 regular {pointer 1}  }
	{ cntrl_busy int 1 regular {pointer 1}  }
	{ cntrl_start_out int 1 regular {pointer 1}  }
	{ axis_in_valid uint 1 regular  }
	{ axis_in_last uint 1 regular  }
	{ axis_in_ready int 1 regular {pointer 1}  }
	{ wl_ready uint 1 regular  }
	{ wl_start int 1 regular {pointer 1}  }
	{ wl_addr_sel int 32 regular {pointer 1}  }
	{ wl_layer int 32 regular {pointer 1}  }
	{ wl_head int 32 regular {pointer 1}  }
	{ wl_tile int 32 regular {pointer 1}  }
	{ dma_done uint 1 regular  }
	{ compute_ready uint 1 regular  }
	{ compute_done uint 1 regular  }
	{ requant_ready uint 1 unused  }
	{ requant_done uint 1 unused  }
	{ head_ctx_ref_0 int 66 regular {pointer 2}  }
	{ head_ctx_ref_1 int 66 regular {pointer 2}  }
	{ head_ctx_ref_2 int 66 regular {pointer 2}  }
	{ head_ctx_ref_3 int 66 regular {pointer 2}  }
	{ compute_start int 1 regular {pointer 1}  }
	{ compute_op int 32 regular {pointer 1}  }
	{ requant_start int 1 regular {pointer 1}  }
	{ requant_op int 32 regular {pointer 1}  }
	{ stream_ready uint 1 regular  }
	{ stream_start int 1 regular {pointer 1}  }
	{ stream_done uint 1 regular  }
	{ done int 1 regular {pointer 1}  }
	{ debug_compute_done int 32 regular {pointer 1}  }
	{ STATE int 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "cntrl_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "cntrl_reset_n", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "cntrl_layer_idx", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "cntrl_busy", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "cntrl_start_out", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "axis_in_valid", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "axis_in_last", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "axis_in_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_addr_sel", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_layer", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_head", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_tile", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dma_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "requant_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "requant_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_0", "interface" : "wire", "bitwidth" : 66, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_1", "interface" : "wire", "bitwidth" : 66, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_2", "interface" : "wire", "bitwidth" : 66, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_3", "interface" : "wire", "bitwidth" : 66, "direction" : "READWRITE"} , 
 	{ "Name" : "compute_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "compute_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "requant_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "requant_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "stream_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "stream_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "stream_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "done", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "debug_compute_done", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "STATE", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 64
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ cntrl_start sc_in sc_lv 1 signal 0 } 
	{ cntrl_reset_n sc_in sc_lv 1 signal 1 } 
	{ cntrl_layer_idx sc_out sc_lv 32 signal 2 } 
	{ cntrl_layer_idx_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ cntrl_busy sc_out sc_lv 1 signal 3 } 
	{ cntrl_busy_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ cntrl_start_out sc_out sc_lv 1 signal 4 } 
	{ cntrl_start_out_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ axis_in_valid sc_in sc_lv 1 signal 5 } 
	{ axis_in_last sc_in sc_lv 1 signal 6 } 
	{ axis_in_ready sc_out sc_lv 1 signal 7 } 
	{ axis_in_ready_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ wl_ready sc_in sc_lv 1 signal 8 } 
	{ wl_start sc_out sc_lv 1 signal 9 } 
	{ wl_start_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ wl_addr_sel sc_out sc_lv 32 signal 10 } 
	{ wl_addr_sel_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ wl_layer sc_out sc_lv 32 signal 11 } 
	{ wl_layer_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ wl_head sc_out sc_lv 32 signal 12 } 
	{ wl_head_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ wl_tile sc_out sc_lv 32 signal 13 } 
	{ wl_tile_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ dma_done sc_in sc_lv 1 signal 14 } 
	{ compute_ready sc_in sc_lv 1 signal 15 } 
	{ compute_done sc_in sc_lv 1 signal 16 } 
	{ requant_ready sc_in sc_lv 1 signal 17 } 
	{ requant_done sc_in sc_lv 1 signal 18 } 
	{ head_ctx_ref_0_i sc_in sc_lv 66 signal 19 } 
	{ head_ctx_ref_0_o sc_out sc_lv 66 signal 19 } 
	{ head_ctx_ref_0_o_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ head_ctx_ref_1_i sc_in sc_lv 66 signal 20 } 
	{ head_ctx_ref_1_o sc_out sc_lv 66 signal 20 } 
	{ head_ctx_ref_1_o_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ head_ctx_ref_2_i sc_in sc_lv 66 signal 21 } 
	{ head_ctx_ref_2_o sc_out sc_lv 66 signal 21 } 
	{ head_ctx_ref_2_o_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ head_ctx_ref_3_i sc_in sc_lv 66 signal 22 } 
	{ head_ctx_ref_3_o sc_out sc_lv 66 signal 22 } 
	{ head_ctx_ref_3_o_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ compute_start sc_out sc_lv 1 signal 23 } 
	{ compute_start_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ compute_op sc_out sc_lv 32 signal 24 } 
	{ compute_op_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ requant_start sc_out sc_lv 1 signal 25 } 
	{ requant_start_ap_vld sc_out sc_logic 1 outvld 25 } 
	{ requant_op sc_out sc_lv 32 signal 26 } 
	{ requant_op_ap_vld sc_out sc_logic 1 outvld 26 } 
	{ stream_ready sc_in sc_lv 1 signal 27 } 
	{ stream_start sc_out sc_lv 1 signal 28 } 
	{ stream_start_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ stream_done sc_in sc_lv 1 signal 29 } 
	{ done sc_out sc_lv 1 signal 30 } 
	{ done_ap_vld sc_out sc_logic 1 outvld 30 } 
	{ debug_compute_done sc_out sc_lv 32 signal 31 } 
	{ debug_compute_done_ap_vld sc_out sc_logic 1 outvld 31 } 
	{ STATE sc_out sc_lv 32 signal 32 } 
	{ STATE_ap_vld sc_out sc_logic 1 outvld 32 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "cntrl_start", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cntrl_start", "role": "default" }} , 
 	{ "name": "cntrl_reset_n", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cntrl_reset_n", "role": "default" }} , 
 	{ "name": "cntrl_layer_idx", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cntrl_layer_idx", "role": "default" }} , 
 	{ "name": "cntrl_layer_idx_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "cntrl_layer_idx", "role": "ap_vld" }} , 
 	{ "name": "cntrl_busy", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cntrl_busy", "role": "default" }} , 
 	{ "name": "cntrl_busy_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "cntrl_busy", "role": "ap_vld" }} , 
 	{ "name": "cntrl_start_out", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cntrl_start_out", "role": "default" }} , 
 	{ "name": "cntrl_start_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "cntrl_start_out", "role": "ap_vld" }} , 
 	{ "name": "axis_in_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "axis_in_valid", "role": "default" }} , 
 	{ "name": "axis_in_last", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "axis_in_last", "role": "default" }} , 
 	{ "name": "axis_in_ready", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "axis_in_ready", "role": "default" }} , 
 	{ "name": "axis_in_ready_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "axis_in_ready", "role": "ap_vld" }} , 
 	{ "name": "wl_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_ready", "role": "default" }} , 
 	{ "name": "wl_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_start", "role": "default" }} , 
 	{ "name": "wl_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_start", "role": "ap_vld" }} , 
 	{ "name": "wl_addr_sel", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_addr_sel", "role": "default" }} , 
 	{ "name": "wl_addr_sel_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_addr_sel", "role": "ap_vld" }} , 
 	{ "name": "wl_layer", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_layer", "role": "default" }} , 
 	{ "name": "wl_layer_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_layer", "role": "ap_vld" }} , 
 	{ "name": "wl_head", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_head", "role": "default" }} , 
 	{ "name": "wl_head_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_head", "role": "ap_vld" }} , 
 	{ "name": "wl_tile", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_tile", "role": "default" }} , 
 	{ "name": "wl_tile_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_tile", "role": "ap_vld" }} , 
 	{ "name": "dma_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dma_done", "role": "default" }} , 
 	{ "name": "compute_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_ready", "role": "default" }} , 
 	{ "name": "compute_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_done", "role": "default" }} , 
 	{ "name": "requant_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_ready", "role": "default" }} , 
 	{ "name": "requant_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_done", "role": "default" }} , 
 	{ "name": "head_ctx_ref_0_i", "direction": "in", "datatype": "sc_lv", "bitwidth":66, "type": "signal", "bundle":{"name": "head_ctx_ref_0", "role": "i" }} , 
 	{ "name": "head_ctx_ref_0_o", "direction": "out", "datatype": "sc_lv", "bitwidth":66, "type": "signal", "bundle":{"name": "head_ctx_ref_0", "role": "o" }} , 
 	{ "name": "head_ctx_ref_0_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_0", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_1_i", "direction": "in", "datatype": "sc_lv", "bitwidth":66, "type": "signal", "bundle":{"name": "head_ctx_ref_1", "role": "i" }} , 
 	{ "name": "head_ctx_ref_1_o", "direction": "out", "datatype": "sc_lv", "bitwidth":66, "type": "signal", "bundle":{"name": "head_ctx_ref_1", "role": "o" }} , 
 	{ "name": "head_ctx_ref_1_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_1", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_2_i", "direction": "in", "datatype": "sc_lv", "bitwidth":66, "type": "signal", "bundle":{"name": "head_ctx_ref_2", "role": "i" }} , 
 	{ "name": "head_ctx_ref_2_o", "direction": "out", "datatype": "sc_lv", "bitwidth":66, "type": "signal", "bundle":{"name": "head_ctx_ref_2", "role": "o" }} , 
 	{ "name": "head_ctx_ref_2_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_2", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_3_i", "direction": "in", "datatype": "sc_lv", "bitwidth":66, "type": "signal", "bundle":{"name": "head_ctx_ref_3", "role": "i" }} , 
 	{ "name": "head_ctx_ref_3_o", "direction": "out", "datatype": "sc_lv", "bitwidth":66, "type": "signal", "bundle":{"name": "head_ctx_ref_3", "role": "o" }} , 
 	{ "name": "head_ctx_ref_3_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_3", "role": "o_ap_vld" }} , 
 	{ "name": "compute_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "default" }} , 
 	{ "name": "compute_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_start", "role": "ap_vld" }} , 
 	{ "name": "compute_op", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_op", "role": "default" }} , 
 	{ "name": "compute_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_op", "role": "ap_vld" }} , 
 	{ "name": "requant_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_start", "role": "default" }} , 
 	{ "name": "requant_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "requant_start", "role": "ap_vld" }} , 
 	{ "name": "requant_op", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "requant_op", "role": "default" }} , 
 	{ "name": "requant_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "requant_op", "role": "ap_vld" }} , 
 	{ "name": "stream_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_ready", "role": "default" }} , 
 	{ "name": "stream_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_start", "role": "default" }} , 
 	{ "name": "stream_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "stream_start", "role": "ap_vld" }} , 
 	{ "name": "stream_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_done", "role": "default" }} , 
 	{ "name": "done", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "done", "role": "default" }} , 
 	{ "name": "done_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "done", "role": "ap_vld" }} , 
 	{ "name": "debug_compute_done", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "debug_compute_done", "role": "default" }} , 
 	{ "name": "debug_compute_done_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "debug_compute_done", "role": "ap_vld" }} , 
 	{ "name": "STATE", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "STATE", "role": "default" }} , 
 	{ "name": "STATE_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "STATE", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	scheduler_hls {
		cntrl_start {Type I LastRead 0 FirstWrite -1}
		cntrl_reset_n {Type I LastRead 0 FirstWrite -1}
		cntrl_layer_idx {Type O LastRead -1 FirstWrite 1}
		cntrl_busy {Type O LastRead -1 FirstWrite 1}
		cntrl_start_out {Type O LastRead -1 FirstWrite 1}
		axis_in_valid {Type I LastRead 0 FirstWrite -1}
		axis_in_last {Type I LastRead 0 FirstWrite -1}
		axis_in_ready {Type O LastRead -1 FirstWrite 1}
		wl_ready {Type I LastRead 0 FirstWrite -1}
		wl_start {Type O LastRead -1 FirstWrite 1}
		wl_addr_sel {Type O LastRead -1 FirstWrite 1}
		wl_layer {Type O LastRead -1 FirstWrite 1}
		wl_head {Type O LastRead -1 FirstWrite 1}
		wl_tile {Type O LastRead -1 FirstWrite 1}
		dma_done {Type I LastRead 0 FirstWrite -1}
		compute_ready {Type I LastRead 0 FirstWrite -1}
		compute_done {Type I LastRead 0 FirstWrite -1}
		requant_ready {Type I LastRead -1 FirstWrite -1}
		requant_done {Type I LastRead -1 FirstWrite -1}
		head_ctx_ref_0 {Type IO LastRead 0 FirstWrite 0}
		head_ctx_ref_1 {Type IO LastRead 0 FirstWrite 0}
		head_ctx_ref_2 {Type IO LastRead 0 FirstWrite 0}
		head_ctx_ref_3 {Type IO LastRead 0 FirstWrite 0}
		compute_start {Type O LastRead -1 FirstWrite 1}
		compute_op {Type O LastRead -1 FirstWrite 1}
		requant_start {Type O LastRead -1 FirstWrite 0}
		requant_op {Type O LastRead -1 FirstWrite 0}
		stream_ready {Type I LastRead 0 FirstWrite -1}
		stream_start {Type O LastRead -1 FirstWrite 1}
		stream_done {Type I LastRead 0 FirstWrite -1}
		done {Type O LastRead -1 FirstWrite 1}
		debug_compute_done {Type O LastRead -1 FirstWrite 1}
		STATE {Type O LastRead -1 FirstWrite 1}
		attn_started {Type IO LastRead -1 FirstWrite -1}
		attn_compute_done {Type IO LastRead -1 FirstWrite -1}
		group_idx {Type IO LastRead -1 FirstWrite -1}
		start_head_group {Type IO LastRead -1 FirstWrite -1}
		concat_compute_done {Type IO LastRead -1 FirstWrite -1}
		concat_started {Type IO LastRead -1 FirstWrite -1}
		outproj_started {Type IO LastRead -1 FirstWrite -1}
		outproj_compute_done {Type IO LastRead -1 FirstWrite -1}
		resid0_started {Type IO LastRead -1 FirstWrite -1}
		resid0_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln0_started {Type IO LastRead -1 FirstWrite -1}
		ln0_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_act_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w2_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_stage {Type IO LastRead -1 FirstWrite -1}
		ffn_started {Type IO LastRead -1 FirstWrite -1}
		resid1_started {Type IO LastRead -1 FirstWrite -1}
		resid1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln1_started {Type IO LastRead -1 FirstWrite -1}
		ln1_compute_done {Type IO LastRead -1 FirstWrite -1}
		st {Type IO LastRead -1 FirstWrite -1}
		layer_idx {Type IO LastRead -1 FirstWrite -1}
		stream_started {Type IO LastRead -1 FirstWrite -1}
		wo_tile {Type IO LastRead -1 FirstWrite -1}
		wo_dma_busy {Type IO LastRead -1 FirstWrite -1}
		wo_comp_busy {Type IO LastRead -1 FirstWrite -1}
		w1_tile {Type IO LastRead -1 FirstWrite -1}
		w1_dma_busy {Type IO LastRead -1 FirstWrite -1}
		w1_comp_busy {Type IO LastRead -1 FirstWrite -1}
		w2_tile {Type IO LastRead -1 FirstWrite -1}
		w2_dma_busy {Type IO LastRead -1 FirstWrite -1}
		w2_comp_busy {Type IO LastRead -1 FirstWrite -1}}
	drive_group_head_phase {
		p_read {Type I LastRead 0 FirstWrite -1}
		p_read1 {Type I LastRead 0 FirstWrite -1}
		p_read2 {Type I LastRead 0 FirstWrite -1}
		p_read3 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read_7 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read_8 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read_9 {Type I LastRead 0 FirstWrite -1}
		p_read8 {Type I LastRead 0 FirstWrite -1}
		p_read9 {Type I LastRead 0 FirstWrite -1}
		p_read10 {Type I LastRead 0 FirstWrite -1}
		p_read11 {Type I LastRead 0 FirstWrite -1}
		p_read12 {Type I LastRead 0 FirstWrite -1}
		p_read13 {Type I LastRead 0 FirstWrite -1}
		p_read14 {Type I LastRead 0 FirstWrite -1}
		p_read15 {Type I LastRead 0 FirstWrite -1}
		p_read16 {Type I LastRead 0 FirstWrite -1}
		p_read17 {Type I LastRead 0 FirstWrite -1}
		p_read18 {Type I LastRead 0 FirstWrite -1}
		p_read19 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_compute_op_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_compute_op_read_11 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_compute_op_read_12 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_compute_op_read_13 {Type I LastRead 0 FirstWrite -1}
		p_read24 {Type I LastRead 0 FirstWrite -1}
		p_read25 {Type I LastRead 0 FirstWrite -1}
		p_read26 {Type I LastRead 0 FirstWrite -1}
		p_read27 {Type I LastRead 0 FirstWrite -1}
		p_read28 {Type I LastRead 0 FirstWrite -1}
		p_read29 {Type I LastRead 0 FirstWrite -1}
		p_read30 {Type I LastRead 0 FirstWrite -1}
		p_read31 {Type I LastRead 0 FirstWrite -1}
		p_read32 {Type I LastRead 0 FirstWrite -1}
		p_read33 {Type I LastRead 0 FirstWrite -1}
		p_read34 {Type I LastRead 0 FirstWrite -1}
		p_read35 {Type I LastRead 0 FirstWrite -1}
		p_read36 {Type I LastRead 0 FirstWrite -1}
		p_read37 {Type I LastRead 0 FirstWrite -1}
		p_read38 {Type I LastRead 0 FirstWrite -1}
		p_read39 {Type I LastRead 0 FirstWrite -1}
		p_read40 {Type I LastRead 0 FirstWrite -1}
		p_read41 {Type I LastRead 0 FirstWrite -1}
		p_read42 {Type I LastRead 0 FirstWrite -1}
		p_read43 {Type I LastRead 0 FirstWrite -1}
		p_read44 {Type I LastRead 0 FirstWrite -1}
		p_read45 {Type I LastRead 0 FirstWrite -1}
		p_read46 {Type I LastRead 0 FirstWrite -1}
		p_read47 {Type I LastRead 0 FirstWrite -1}
		p_read48 {Type I LastRead 0 FirstWrite -1}
		p_read49 {Type I LastRead 0 FirstWrite -1}
		p_read50 {Type I LastRead 0 FirstWrite -1}
		p_read51 {Type I LastRead 0 FirstWrite -1}
		p_read52 {Type I LastRead 0 FirstWrite -1}
		p_read53 {Type I LastRead 0 FirstWrite -1}
		p_read54 {Type I LastRead 0 FirstWrite -1}
		p_read55 {Type I LastRead 0 FirstWrite -1}
		p_read56 {Type I LastRead 0 FirstWrite -1}
		p_read57 {Type I LastRead 0 FirstWrite -1}
		p_read58 {Type I LastRead 0 FirstWrite -1}
		p_read59 {Type I LastRead 0 FirstWrite -1}
		p_read60 {Type I LastRead 0 FirstWrite -1}
		p_read61 {Type I LastRead 0 FirstWrite -1}
		p_read62 {Type I LastRead 0 FirstWrite -1}
		p_read63 {Type I LastRead 0 FirstWrite -1}
		p_read64 {Type I LastRead 0 FirstWrite -1}
		p_read65 {Type I LastRead 0 FirstWrite -1}
		p_read66 {Type I LastRead 0 FirstWrite -1}
		p_read67 {Type I LastRead 0 FirstWrite -1}
		p_read68 {Type I LastRead 0 FirstWrite -1}
		p_read69 {Type I LastRead 0 FirstWrite -1}
		p_read70 {Type I LastRead 0 FirstWrite -1}
		p_read71 {Type I LastRead 0 FirstWrite -1}
		p_read72 {Type I LastRead 0 FirstWrite -1}
		p_read73 {Type I LastRead 0 FirstWrite -1}
		p_read74 {Type I LastRead 0 FirstWrite -1}
		p_read75 {Type I LastRead 0 FirstWrite -1}
		p_read76 {Type I LastRead 0 FirstWrite -1}
		p_read77 {Type I LastRead 0 FirstWrite -1}
		p_read78 {Type I LastRead 0 FirstWrite -1}
		p_read79 {Type I LastRead 0 FirstWrite -1}
		p_read80 {Type I LastRead 0 FirstWrite -1}
		p_read81 {Type I LastRead 0 FirstWrite -1}
		p_read82 {Type I LastRead 0 FirstWrite -1}
		p_read83 {Type I LastRead 0 FirstWrite -1}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		start_r {Type I LastRead 0 FirstWrite -1}}
	run_single_head {
		ctx_layer_stamp_read_5 {Type I LastRead 0 FirstWrite -1}
		ctx_layer_stamp_read {Type I LastRead 0 FirstWrite -1}
		ctx_phase_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_ready_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_op_read {Type I LastRead 0 FirstWrite -1}
		ctx_start_head_read {Type I LastRead 0 FirstWrite -1}
		ctx_q_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_k_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_v_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_scores_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_val_scale_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_softmax_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_value_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_q_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_k_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_v_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_scores_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_val_scale_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_softmax_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_value_compute_done_read {Type I LastRead 0 FirstWrite -1}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		start_r {Type I LastRead 0 FirstWrite -1}}
	run_single_head {
		ctx_layer_stamp_read_5 {Type I LastRead 0 FirstWrite -1}
		ctx_layer_stamp_read {Type I LastRead 0 FirstWrite -1}
		ctx_phase_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_ready_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_op_read {Type I LastRead 0 FirstWrite -1}
		ctx_start_head_read {Type I LastRead 0 FirstWrite -1}
		ctx_q_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_k_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_v_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_scores_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_val_scale_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_softmax_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_value_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_q_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_k_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_v_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_scores_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_val_scale_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_softmax_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_value_compute_done_read {Type I LastRead 0 FirstWrite -1}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		start_r {Type I LastRead 0 FirstWrite -1}}
	run_single_head {
		ctx_layer_stamp_read_5 {Type I LastRead 0 FirstWrite -1}
		ctx_layer_stamp_read {Type I LastRead 0 FirstWrite -1}
		ctx_phase_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_ready_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_op_read {Type I LastRead 0 FirstWrite -1}
		ctx_start_head_read {Type I LastRead 0 FirstWrite -1}
		ctx_q_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_k_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_v_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_scores_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_val_scale_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_softmax_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_value_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_q_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_k_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_v_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_scores_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_val_scale_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_softmax_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_value_compute_done_read {Type I LastRead 0 FirstWrite -1}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		start_r {Type I LastRead 0 FirstWrite -1}}
	run_single_head {
		ctx_layer_stamp_read_5 {Type I LastRead 0 FirstWrite -1}
		ctx_layer_stamp_read {Type I LastRead 0 FirstWrite -1}
		ctx_phase_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_ready_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_compute_op_read {Type I LastRead 0 FirstWrite -1}
		ctx_start_head_read {Type I LastRead 0 FirstWrite -1}
		ctx_q_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_k_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_v_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_scores_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_val_scale_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_softmax_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_value_started_read {Type I LastRead 0 FirstWrite -1}
		ctx_q_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_k_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_v_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_scores_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_val_scale_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_softmax_compute_done_read {Type I LastRead 0 FirstWrite -1}
		ctx_att_value_compute_done_read {Type I LastRead 0 FirstWrite -1}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		start_r {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "1"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "2"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	cntrl_start { ap_none {  { cntrl_start in_data 0 1 } } }
	cntrl_reset_n { ap_none {  { cntrl_reset_n in_data 0 1 } } }
	cntrl_layer_idx { ap_vld {  { cntrl_layer_idx out_data 1 32 }  { cntrl_layer_idx_ap_vld out_vld 1 1 } } }
	cntrl_busy { ap_vld {  { cntrl_busy out_data 1 1 }  { cntrl_busy_ap_vld out_vld 1 1 } } }
	cntrl_start_out { ap_vld {  { cntrl_start_out out_data 1 1 }  { cntrl_start_out_ap_vld out_vld 1 1 } } }
	axis_in_valid { ap_none {  { axis_in_valid in_data 0 1 } } }
	axis_in_last { ap_none {  { axis_in_last in_data 0 1 } } }
	axis_in_ready { ap_vld {  { axis_in_ready out_data 1 1 }  { axis_in_ready_ap_vld out_vld 1 1 } } }
	wl_ready { ap_none {  { wl_ready in_data 0 1 } } }
	wl_start { ap_vld {  { wl_start out_data 1 1 }  { wl_start_ap_vld out_vld 1 1 } } }
	wl_addr_sel { ap_vld {  { wl_addr_sel out_data 1 32 }  { wl_addr_sel_ap_vld out_vld 1 1 } } }
	wl_layer { ap_vld {  { wl_layer out_data 1 32 }  { wl_layer_ap_vld out_vld 1 1 } } }
	wl_head { ap_vld {  { wl_head out_data 1 32 }  { wl_head_ap_vld out_vld 1 1 } } }
	wl_tile { ap_vld {  { wl_tile out_data 1 32 }  { wl_tile_ap_vld out_vld 1 1 } } }
	dma_done { ap_none {  { dma_done in_data 0 1 } } }
	compute_ready { ap_none {  { compute_ready in_data 0 1 } } }
	compute_done { ap_none {  { compute_done in_data 0 1 } } }
	requant_ready { ap_none {  { requant_ready in_data 0 1 } } }
	requant_done { ap_none {  { requant_done in_data 0 1 } } }
	head_ctx_ref_0 { ap_ovld {  { head_ctx_ref_0_i in_data 0 66 }  { head_ctx_ref_0_o out_data 1 66 }  { head_ctx_ref_0_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_1 { ap_ovld {  { head_ctx_ref_1_i in_data 0 66 }  { head_ctx_ref_1_o out_data 1 66 }  { head_ctx_ref_1_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_2 { ap_ovld {  { head_ctx_ref_2_i in_data 0 66 }  { head_ctx_ref_2_o out_data 1 66 }  { head_ctx_ref_2_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_3 { ap_ovld {  { head_ctx_ref_3_i in_data 0 66 }  { head_ctx_ref_3_o out_data 1 66 }  { head_ctx_ref_3_o_ap_vld out_vld 1 1 } } }
	compute_start { ap_vld {  { compute_start out_data 1 1 }  { compute_start_ap_vld out_vld 1 1 } } }
	compute_op { ap_vld {  { compute_op out_data 1 32 }  { compute_op_ap_vld out_vld 1 1 } } }
	requant_start { ap_vld {  { requant_start out_data 1 1 }  { requant_start_ap_vld out_vld 1 1 } } }
	requant_op { ap_vld {  { requant_op out_data 1 32 }  { requant_op_ap_vld out_vld 1 1 } } }
	stream_ready { ap_none {  { stream_ready in_data 0 1 } } }
	stream_start { ap_vld {  { stream_start out_data 1 1 }  { stream_start_ap_vld out_vld 1 1 } } }
	stream_done { ap_none {  { stream_done in_data 0 1 } } }
	done { ap_vld {  { done out_data 1 1 }  { done_ap_vld out_vld 1 1 } } }
	debug_compute_done { ap_vld {  { debug_compute_done out_data 1 32 }  { debug_compute_done_ap_vld out_vld 1 1 } } }
	STATE { ap_vld {  { STATE out_data 1 32 }  { STATE_ap_vld out_vld 1 1 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
