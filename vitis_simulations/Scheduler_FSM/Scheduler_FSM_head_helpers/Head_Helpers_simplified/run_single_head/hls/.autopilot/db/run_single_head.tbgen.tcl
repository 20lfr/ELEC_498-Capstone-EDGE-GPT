set moduleName run_single_head
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
set C_modelName {run_single_head}
set C_modelType { int 1 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ ctx int 51 regular {pointer 2}  }
	{ layer_idx int 32 regular  }
	{ start_r uint 1 regular  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "ctx", "interface" : "wire", "bitwidth" : 51, "direction" : "READWRITE"} , 
 	{ "Name" : "layer_idx", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "start_r", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 1} ]}
# RTL Port declarations: 
set portNum 12
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ctx_i sc_in sc_lv 51 signal 0 } 
	{ ctx_o sc_out sc_lv 51 signal 0 } 
	{ ctx_o_ap_vld sc_out sc_logic 1 outvld 0 } 
	{ layer_idx sc_in sc_lv 32 signal 1 } 
	{ start_r sc_in sc_lv 1 signal 2 } 
	{ ap_return sc_out sc_lv 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ctx_i", "direction": "in", "datatype": "sc_lv", "bitwidth":51, "type": "signal", "bundle":{"name": "ctx", "role": "i" }} , 
 	{ "name": "ctx_o", "direction": "out", "datatype": "sc_lv", "bitwidth":51, "type": "signal", "bundle":{"name": "ctx", "role": "o" }} , 
 	{ "name": "ctx_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "ctx", "role": "o_ap_vld" }} , 
 	{ "name": "layer_idx", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layer_idx", "role": "default" }} , 
 	{ "name": "start_r", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "start_r", "role": "default" }} , 
 	{ "name": "ap_return", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	run_single_head {
		ctx {Type IO LastRead 0 FirstWrite 0}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		start_r {Type I LastRead 0 FirstWrite -1}
		Q_started {Type IO LastRead -1 FirstWrite -1}
		K_started {Type IO LastRead -1 FirstWrite -1}
		V_started {Type IO LastRead -1 FirstWrite -1}
		att_scores_started {Type IO LastRead -1 FirstWrite -1}
		val_scale_started {Type IO LastRead -1 FirstWrite -1}
		softmax_started {Type IO LastRead -1 FirstWrite -1}
		att_value_started {Type IO LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	ctx { ap_ovld {  { ctx_i in_data 0 51 }  { ctx_o out_data 1 51 }  { ctx_o_ap_vld out_vld 1 1 } } }
	layer_idx { ap_none {  { layer_idx in_data 0 32 } } }
	start_r { ap_none {  { start_r in_data 0 1 } } }
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
