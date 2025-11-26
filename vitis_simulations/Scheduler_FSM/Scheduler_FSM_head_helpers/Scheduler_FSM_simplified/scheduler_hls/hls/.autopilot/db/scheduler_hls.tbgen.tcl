set moduleName scheduler_hls
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 1
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 2
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
	{ compute_start int 1 regular {pointer 1}  }
	{ compute_op int 32 regular {pointer 1}  }
	{ requant_start int 1 regular {pointer 1}  }
	{ requant_op int 32 regular {pointer 1}  }
	{ stream_ready uint 1 regular  }
	{ stream_start int 1 regular {pointer 1}  }
	{ stream_done uint 1 regular  }
	{ done int 1 regular {pointer 1}  }
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
 	{ "Name" : "compute_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "compute_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "requant_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "requant_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "stream_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "stream_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "stream_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "done", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "STATE", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 50
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
	{ compute_start sc_out sc_lv 1 signal 19 } 
	{ compute_start_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ compute_op sc_out sc_lv 32 signal 20 } 
	{ compute_op_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ requant_start sc_out sc_lv 1 signal 21 } 
	{ requant_start_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ requant_op sc_out sc_lv 32 signal 22 } 
	{ requant_op_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ stream_ready sc_in sc_lv 1 signal 23 } 
	{ stream_start sc_out sc_lv 1 signal 24 } 
	{ stream_start_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ stream_done sc_in sc_lv 1 signal 25 } 
	{ done sc_out sc_lv 1 signal 26 } 
	{ done_ap_vld sc_out sc_logic 1 outvld 26 } 
	{ STATE sc_out sc_lv 32 signal 27 } 
	{ STATE_ap_vld sc_out sc_logic 1 outvld 27 } 
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
 	{ "name": "STATE", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "STATE", "role": "default" }} , 
 	{ "name": "STATE_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "STATE", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	scheduler_hls {
		cntrl_start {Type I LastRead 0 FirstWrite -1}
		cntrl_reset_n {Type I LastRead 0 FirstWrite -1}
		cntrl_layer_idx {Type O LastRead -1 FirstWrite 0}
		cntrl_busy {Type O LastRead -1 FirstWrite 0}
		cntrl_start_out {Type O LastRead -1 FirstWrite 0}
		axis_in_valid {Type I LastRead 0 FirstWrite -1}
		axis_in_last {Type I LastRead 0 FirstWrite -1}
		axis_in_ready {Type O LastRead -1 FirstWrite 0}
		wl_ready {Type I LastRead 0 FirstWrite -1}
		wl_start {Type O LastRead -1 FirstWrite 0}
		wl_addr_sel {Type O LastRead -1 FirstWrite 0}
		wl_layer {Type O LastRead -1 FirstWrite 0}
		wl_head {Type O LastRead -1 FirstWrite 0}
		wl_tile {Type O LastRead -1 FirstWrite 0}
		dma_done {Type I LastRead 0 FirstWrite -1}
		compute_ready {Type I LastRead 0 FirstWrite -1}
		compute_done {Type I LastRead 0 FirstWrite -1}
		requant_ready {Type I LastRead -1 FirstWrite -1}
		requant_done {Type I LastRead -1 FirstWrite -1}
		compute_start {Type O LastRead -1 FirstWrite 0}
		compute_op {Type O LastRead -1 FirstWrite 0}
		requant_start {Type O LastRead -1 FirstWrite 0}
		requant_op {Type O LastRead -1 FirstWrite 0}
		stream_ready {Type I LastRead 0 FirstWrite -1}
		stream_start {Type O LastRead -1 FirstWrite 0}
		stream_done {Type I LastRead 0 FirstWrite -1}
		done {Type O LastRead -1 FirstWrite 0}
		STATE {Type O LastRead -1 FirstWrite 0}
		ffn_started {Type IO LastRead -1 FirstWrite -1}
		st {Type IO LastRead -1 FirstWrite -1}
		layer_idx {Type IO LastRead -1 FirstWrite -1}
		attn_started {Type IO LastRead -1 FirstWrite -1}
		concat_started {Type IO LastRead -1 FirstWrite -1}
		outproj_started {Type IO LastRead -1 FirstWrite -1}
		wo_tile {Type IO LastRead -1 FirstWrite -1}
		wo_dma_busy {Type IO LastRead -1 FirstWrite -1}
		wo_comp_busy {Type IO LastRead -1 FirstWrite -1}
		resid0_started {Type IO LastRead -1 FirstWrite -1}
		ln0_started {Type IO LastRead -1 FirstWrite -1}
		ffn_stage {Type IO LastRead -1 FirstWrite -1}
		resid1_started {Type IO LastRead -1 FirstWrite -1}
		ln1_started {Type IO LastRead -1 FirstWrite -1}
		stream_started {Type IO LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
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
	compute_start { ap_vld {  { compute_start out_data 1 1 }  { compute_start_ap_vld out_vld 1 1 } } }
	compute_op { ap_vld {  { compute_op out_data 1 32 }  { compute_op_ap_vld out_vld 1 1 } } }
	requant_start { ap_vld {  { requant_start out_data 1 1 }  { requant_start_ap_vld out_vld 1 1 } } }
	requant_op { ap_vld {  { requant_op out_data 1 32 }  { requant_op_ap_vld out_vld 1 1 } } }
	stream_ready { ap_none {  { stream_ready in_data 0 1 } } }
	stream_start { ap_vld {  { stream_start out_data 1 1 }  { stream_start_ap_vld out_vld 1 1 } } }
	stream_done { ap_none {  { stream_done in_data 0 1 } } }
	done { ap_vld {  { done out_data 1 1 }  { done_ap_vld out_vld 1 1 } } }
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
