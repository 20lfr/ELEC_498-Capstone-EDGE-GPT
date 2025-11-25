set moduleName run_head_group
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
set cdfgNum 2
set C_modelName {run_head_group}
set C_modelType { int 1 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict head_ctx_ref { MEM_WIDTH 46 MEM_SIZE 48 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ head_ctx_ref int 46 regular {array 8 { 2 2 } 1 1 }  }
	{ res int 140 regular {pointer 2}  }
	{ layer_idx int 32 regular  }
	{ group_idx int 32 regular  }
	{ reset_resources uint 1 regular  }
	{ wl_ready uint 1 unused  }
	{ dma_done uint 1 unused  }
	{ compute_ready uint 1 regular  }
	{ compute_done uint 1 regular  }
	{ requant_ready uint 1 unused  }
	{ requant_done uint 1 unused  }
	{ wl_start int 1 regular {pointer 1}  }
	{ wl_addr_sel int 32 regular {pointer 1}  }
	{ wl_layer int 32 regular {pointer 1}  }
	{ wl_head int 32 regular {pointer 1}  }
	{ wl_tile int 32 regular {pointer 1}  }
	{ compute_start int 1 regular {pointer 1}  }
	{ compute_op int 32 regular {pointer 1}  }
	{ requant_start int 1 regular {pointer 1}  }
	{ requant_op int 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "head_ctx_ref", "interface" : "memory", "bitwidth" : 46, "direction" : "READWRITE"} , 
 	{ "Name" : "res", "interface" : "wire", "bitwidth" : 140, "direction" : "READWRITE"} , 
 	{ "Name" : "layer_idx", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "group_idx", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "reset_resources", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "dma_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "requant_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "requant_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_addr_sel", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_layer", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_head", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_tile", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "compute_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "compute_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "requant_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "requant_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 1} ]}
# RTL Port declarations: 
set portNum 47
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ head_ctx_ref_address0 sc_out sc_lv 3 signal 0 } 
	{ head_ctx_ref_ce0 sc_out sc_logic 1 signal 0 } 
	{ head_ctx_ref_we0 sc_out sc_logic 1 signal 0 } 
	{ head_ctx_ref_d0 sc_out sc_lv 46 signal 0 } 
	{ head_ctx_ref_q0 sc_in sc_lv 46 signal 0 } 
	{ head_ctx_ref_address1 sc_out sc_lv 3 signal 0 } 
	{ head_ctx_ref_ce1 sc_out sc_logic 1 signal 0 } 
	{ head_ctx_ref_we1 sc_out sc_logic 1 signal 0 } 
	{ head_ctx_ref_d1 sc_out sc_lv 46 signal 0 } 
	{ head_ctx_ref_q1 sc_in sc_lv 46 signal 0 } 
	{ res_i sc_in sc_lv 140 signal 1 } 
	{ res_o sc_out sc_lv 140 signal 1 } 
	{ res_o_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ layer_idx sc_in sc_lv 32 signal 2 } 
	{ group_idx sc_in sc_lv 32 signal 3 } 
	{ reset_resources sc_in sc_lv 1 signal 4 } 
	{ wl_ready sc_in sc_lv 1 signal 5 } 
	{ dma_done sc_in sc_lv 1 signal 6 } 
	{ compute_ready sc_in sc_lv 1 signal 7 } 
	{ compute_done sc_in sc_lv 1 signal 8 } 
	{ requant_ready sc_in sc_lv 1 signal 9 } 
	{ requant_done sc_in sc_lv 1 signal 10 } 
	{ wl_start sc_out sc_lv 1 signal 11 } 
	{ wl_start_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ wl_addr_sel sc_out sc_lv 32 signal 12 } 
	{ wl_addr_sel_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ wl_layer sc_out sc_lv 32 signal 13 } 
	{ wl_layer_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ wl_head sc_out sc_lv 32 signal 14 } 
	{ wl_head_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ wl_tile sc_out sc_lv 32 signal 15 } 
	{ wl_tile_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ compute_start sc_out sc_lv 1 signal 16 } 
	{ compute_start_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ compute_op sc_out sc_lv 32 signal 17 } 
	{ compute_op_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ requant_start sc_out sc_lv 1 signal 18 } 
	{ requant_start_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ requant_op sc_out sc_lv 32 signal 19 } 
	{ requant_op_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ ap_return sc_out sc_lv 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "head_ctx_ref_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "address0" }} , 
 	{ "name": "head_ctx_ref_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "ce0" }} , 
 	{ "name": "head_ctx_ref_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "we0" }} , 
 	{ "name": "head_ctx_ref_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":46, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "d0" }} , 
 	{ "name": "head_ctx_ref_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":46, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "q0" }} , 
 	{ "name": "head_ctx_ref_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "address1" }} , 
 	{ "name": "head_ctx_ref_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "ce1" }} , 
 	{ "name": "head_ctx_ref_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "we1" }} , 
 	{ "name": "head_ctx_ref_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":46, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "d1" }} , 
 	{ "name": "head_ctx_ref_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":46, "type": "signal", "bundle":{"name": "head_ctx_ref", "role": "q1" }} , 
 	{ "name": "res_i", "direction": "in", "datatype": "sc_lv", "bitwidth":140, "type": "signal", "bundle":{"name": "res", "role": "i" }} , 
 	{ "name": "res_o", "direction": "out", "datatype": "sc_lv", "bitwidth":140, "type": "signal", "bundle":{"name": "res", "role": "o" }} , 
 	{ "name": "res_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "res", "role": "o_ap_vld" }} , 
 	{ "name": "layer_idx", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layer_idx", "role": "default" }} , 
 	{ "name": "group_idx", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "group_idx", "role": "default" }} , 
 	{ "name": "reset_resources", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "reset_resources", "role": "default" }} , 
 	{ "name": "wl_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_ready", "role": "default" }} , 
 	{ "name": "dma_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dma_done", "role": "default" }} , 
 	{ "name": "compute_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_ready", "role": "default" }} , 
 	{ "name": "compute_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_done", "role": "default" }} , 
 	{ "name": "requant_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_ready", "role": "default" }} , 
 	{ "name": "requant_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_done", "role": "default" }} , 
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
 	{ "name": "compute_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "default" }} , 
 	{ "name": "compute_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_start", "role": "ap_vld" }} , 
 	{ "name": "compute_op", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_op", "role": "default" }} , 
 	{ "name": "compute_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_op", "role": "ap_vld" }} , 
 	{ "name": "requant_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_start", "role": "default" }} , 
 	{ "name": "requant_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "requant_start", "role": "ap_vld" }} , 
 	{ "name": "requant_op", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "requant_op", "role": "default" }} , 
 	{ "name": "requant_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "requant_op", "role": "ap_vld" }} , 
 	{ "name": "ap_return", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	run_head_group {
		head_ctx_ref {Type IO LastRead 5 FirstWrite 1}
		res {Type IO LastRead 0 FirstWrite 7}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		group_idx {Type I LastRead 0 FirstWrite -1}
		reset_resources {Type I LastRead 0 FirstWrite -1}
		wl_ready {Type I LastRead -1 FirstWrite -1}
		dma_done {Type I LastRead -1 FirstWrite -1}
		compute_ready {Type I LastRead 0 FirstWrite -1}
		compute_done {Type I LastRead 0 FirstWrite -1}
		requant_ready {Type I LastRead -1 FirstWrite -1}
		requant_done {Type I LastRead -1 FirstWrite -1}
		wl_start {Type O LastRead -1 FirstWrite 7}
		wl_addr_sel {Type O LastRead -1 FirstWrite 7}
		wl_layer {Type O LastRead -1 FirstWrite 7}
		wl_head {Type O LastRead -1 FirstWrite 7}
		wl_tile {Type O LastRead -1 FirstWrite 7}
		compute_start {Type O LastRead -1 FirstWrite 7}
		compute_op {Type O LastRead -1 FirstWrite 7}
		requant_start {Type O LastRead -1 FirstWrite 7}
		requant_op {Type O LastRead -1 FirstWrite 7}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "5", "Max" : "7"}
	, {"Name" : "Interval", "Min" : "6", "Max" : "8"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	head_ctx_ref { ap_memory {  { head_ctx_ref_address0 mem_address 1 3 }  { head_ctx_ref_ce0 mem_ce 1 1 }  { head_ctx_ref_we0 mem_we 1 1 }  { head_ctx_ref_d0 mem_din 1 46 }  { head_ctx_ref_q0 mem_dout 0 46 }  { head_ctx_ref_address1 MemPortADDR2 1 3 }  { head_ctx_ref_ce1 MemPortCE2 1 1 }  { head_ctx_ref_we1 MemPortWE2 1 1 }  { head_ctx_ref_d1 MemPortDIN2 1 46 }  { head_ctx_ref_q1 MemPortDOUT2 0 46 } } }
	res { ap_ovld {  { res_i in_data 0 140 }  { res_o out_data 1 140 }  { res_o_ap_vld out_vld 1 1 } } }
	layer_idx { ap_none {  { layer_idx in_data 0 32 } } }
	group_idx { ap_none {  { group_idx in_data 0 32 } } }
	reset_resources { ap_none {  { reset_resources in_data 0 1 } } }
	wl_ready { ap_none {  { wl_ready in_data 0 1 } } }
	dma_done { ap_none {  { dma_done in_data 0 1 } } }
	compute_ready { ap_none {  { compute_ready in_data 0 1 } } }
	compute_done { ap_none {  { compute_done in_data 0 1 } } }
	requant_ready { ap_none {  { requant_ready in_data 0 1 } } }
	requant_done { ap_none {  { requant_done in_data 0 1 } } }
	wl_start { ap_vld {  { wl_start out_data 1 1 }  { wl_start_ap_vld out_vld 1 1 } } }
	wl_addr_sel { ap_vld {  { wl_addr_sel out_data 1 32 }  { wl_addr_sel_ap_vld out_vld 1 1 } } }
	wl_layer { ap_vld {  { wl_layer out_data 1 32 }  { wl_layer_ap_vld out_vld 1 1 } } }
	wl_head { ap_vld {  { wl_head out_data 1 32 }  { wl_head_ap_vld out_vld 1 1 } } }
	wl_tile { ap_vld {  { wl_tile out_data 1 32 }  { wl_tile_ap_vld out_vld 1 1 } } }
	compute_start { ap_vld {  { compute_start out_data 1 1 }  { compute_start_ap_vld out_vld 1 1 } } }
	compute_op { ap_vld {  { compute_op out_data 1 32 }  { compute_op_ap_vld out_vld 1 1 } } }
	requant_start { ap_vld {  { requant_start out_data 1 1 }  { requant_start_ap_vld out_vld 1 1 } } }
	requant_op { ap_vld {  { requant_op out_data 1 32 }  { requant_op_ap_vld out_vld 1 1 } } }
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
