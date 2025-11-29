set moduleName run_single_head
set isTopModule 0
set isCombinational 1
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
set C_modelName {run_single_head}
set C_modelType { int 67 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ ctx_layer_stamp_read_5 int 32 regular  }
	{ ctx_layer_stamp_read int 32 regular  }
	{ ctx_phase_read int 4 regular  }
	{ ctx_compute_ready_read int 1 regular  }
	{ ctx_compute_done_read int 1 regular  }
	{ ctx_compute_op_read int 4 regular  }
	{ ctx_start_head_read int 1 regular  }
	{ ctx_q_started_read int 1 regular  }
	{ ctx_k_started_read int 1 regular  }
	{ ctx_v_started_read int 1 regular  }
	{ ctx_att_scores_started_read int 1 regular  }
	{ ctx_val_scale_started_read int 1 regular  }
	{ ctx_softmax_started_read int 1 regular  }
	{ ctx_att_value_started_read int 1 regular  }
	{ ctx_q_compute_done_read int 1 regular  }
	{ ctx_k_compute_done_read int 1 regular  }
	{ ctx_v_compute_done_read int 1 regular  }
	{ ctx_att_scores_compute_done_read int 1 regular  }
	{ ctx_val_scale_compute_done_read int 1 regular  }
	{ ctx_softmax_compute_done_read int 1 regular  }
	{ ctx_att_value_compute_done_read int 1 regular  }
	{ layer_idx int 32 regular  }
	{ start_r uint 1 regular  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "ctx_layer_stamp_read_5", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_layer_stamp_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_phase_read", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_compute_ready_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_compute_done_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_compute_op_read", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_start_head_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_q_started_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_k_started_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_v_started_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_att_scores_started_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_val_scale_started_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_softmax_started_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_att_value_started_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_q_compute_done_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_k_compute_done_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_v_compute_done_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_att_scores_compute_done_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_val_scale_compute_done_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_softmax_compute_done_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctx_att_value_compute_done_read", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "layer_idx", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "start_r", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 67} ]}
# RTL Port declarations: 
set portNum 47
set portList { 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ctx_layer_stamp_read_5 sc_in sc_lv 32 signal 0 } 
	{ ctx_layer_stamp_read sc_in sc_lv 32 signal 1 } 
	{ ctx_phase_read sc_in sc_lv 4 signal 2 } 
	{ ctx_compute_ready_read sc_in sc_lv 1 signal 3 } 
	{ ctx_compute_done_read sc_in sc_lv 1 signal 4 } 
	{ ctx_compute_op_read sc_in sc_lv 4 signal 5 } 
	{ ctx_start_head_read sc_in sc_lv 1 signal 6 } 
	{ ctx_q_started_read sc_in sc_lv 1 signal 7 } 
	{ ctx_k_started_read sc_in sc_lv 1 signal 8 } 
	{ ctx_v_started_read sc_in sc_lv 1 signal 9 } 
	{ ctx_att_scores_started_read sc_in sc_lv 1 signal 10 } 
	{ ctx_val_scale_started_read sc_in sc_lv 1 signal 11 } 
	{ ctx_softmax_started_read sc_in sc_lv 1 signal 12 } 
	{ ctx_att_value_started_read sc_in sc_lv 1 signal 13 } 
	{ ctx_q_compute_done_read sc_in sc_lv 1 signal 14 } 
	{ ctx_k_compute_done_read sc_in sc_lv 1 signal 15 } 
	{ ctx_v_compute_done_read sc_in sc_lv 1 signal 16 } 
	{ ctx_att_scores_compute_done_read sc_in sc_lv 1 signal 17 } 
	{ ctx_val_scale_compute_done_read sc_in sc_lv 1 signal 18 } 
	{ ctx_softmax_compute_done_read sc_in sc_lv 1 signal 19 } 
	{ ctx_att_value_compute_done_read sc_in sc_lv 1 signal 20 } 
	{ layer_idx sc_in sc_lv 32 signal 21 } 
	{ start_r sc_in sc_lv 1 signal 22 } 
	{ ap_return_0 sc_out sc_lv 1 signal -1 } 
	{ ap_return_1 sc_out sc_lv 8 signal -1 } 
	{ ap_return_2 sc_out sc_lv 1 signal -1 } 
	{ ap_return_3 sc_out sc_lv 1 signal -1 } 
	{ ap_return_4 sc_out sc_lv 1 signal -1 } 
	{ ap_return_5 sc_out sc_lv 8 signal -1 } 
	{ ap_return_6 sc_out sc_lv 1 signal -1 } 
	{ ap_return_7 sc_out sc_lv 1 signal -1 } 
	{ ap_return_8 sc_out sc_lv 1 signal -1 } 
	{ ap_return_9 sc_out sc_lv 1 signal -1 } 
	{ ap_return_10 sc_out sc_lv 1 signal -1 } 
	{ ap_return_11 sc_out sc_lv 1 signal -1 } 
	{ ap_return_12 sc_out sc_lv 1 signal -1 } 
	{ ap_return_13 sc_out sc_lv 1 signal -1 } 
	{ ap_return_14 sc_out sc_lv 1 signal -1 } 
	{ ap_return_15 sc_out sc_lv 1 signal -1 } 
	{ ap_return_16 sc_out sc_lv 1 signal -1 } 
	{ ap_return_17 sc_out sc_lv 1 signal -1 } 
	{ ap_return_18 sc_out sc_lv 1 signal -1 } 
	{ ap_return_19 sc_out sc_lv 1 signal -1 } 
	{ ap_return_20 sc_out sc_lv 1 signal -1 } 
	{ ap_return_21 sc_out sc_lv 32 signal -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
}
set NewPortList {[ 
	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ctx_layer_stamp_read_5", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ctx_layer_stamp_read_5", "role": "default" }} , 
 	{ "name": "ctx_layer_stamp_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ctx_layer_stamp_read", "role": "default" }} , 
 	{ "name": "ctx_phase_read", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "ctx_phase_read", "role": "default" }} , 
 	{ "name": "ctx_compute_ready_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_compute_ready_read", "role": "default" }} , 
 	{ "name": "ctx_compute_done_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_compute_done_read", "role": "default" }} , 
 	{ "name": "ctx_compute_op_read", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "ctx_compute_op_read", "role": "default" }} , 
 	{ "name": "ctx_start_head_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_start_head_read", "role": "default" }} , 
 	{ "name": "ctx_q_started_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_q_started_read", "role": "default" }} , 
 	{ "name": "ctx_k_started_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_k_started_read", "role": "default" }} , 
 	{ "name": "ctx_v_started_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_v_started_read", "role": "default" }} , 
 	{ "name": "ctx_att_scores_started_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_att_scores_started_read", "role": "default" }} , 
 	{ "name": "ctx_val_scale_started_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_val_scale_started_read", "role": "default" }} , 
 	{ "name": "ctx_softmax_started_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_softmax_started_read", "role": "default" }} , 
 	{ "name": "ctx_att_value_started_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_att_value_started_read", "role": "default" }} , 
 	{ "name": "ctx_q_compute_done_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_q_compute_done_read", "role": "default" }} , 
 	{ "name": "ctx_k_compute_done_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_k_compute_done_read", "role": "default" }} , 
 	{ "name": "ctx_v_compute_done_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_v_compute_done_read", "role": "default" }} , 
 	{ "name": "ctx_att_scores_compute_done_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_att_scores_compute_done_read", "role": "default" }} , 
 	{ "name": "ctx_val_scale_compute_done_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_val_scale_compute_done_read", "role": "default" }} , 
 	{ "name": "ctx_softmax_compute_done_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_softmax_compute_done_read", "role": "default" }} , 
 	{ "name": "ctx_att_value_compute_done_read", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctx_att_value_compute_done_read", "role": "default" }} , 
 	{ "name": "layer_idx", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layer_idx", "role": "default" }} , 
 	{ "name": "start_r", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "start_r", "role": "default" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }} , 
 	{ "name": "ap_return_3", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_3", "role": "default" }} , 
 	{ "name": "ap_return_4", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_4", "role": "default" }} , 
 	{ "name": "ap_return_5", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_5", "role": "default" }} , 
 	{ "name": "ap_return_6", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_6", "role": "default" }} , 
 	{ "name": "ap_return_7", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_7", "role": "default" }} , 
 	{ "name": "ap_return_8", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_8", "role": "default" }} , 
 	{ "name": "ap_return_9", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_9", "role": "default" }} , 
 	{ "name": "ap_return_10", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_10", "role": "default" }} , 
 	{ "name": "ap_return_11", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_11", "role": "default" }} , 
 	{ "name": "ap_return_12", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_12", "role": "default" }} , 
 	{ "name": "ap_return_13", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_13", "role": "default" }} , 
 	{ "name": "ap_return_14", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_14", "role": "default" }} , 
 	{ "name": "ap_return_15", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_15", "role": "default" }} , 
 	{ "name": "ap_return_16", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_16", "role": "default" }} , 
 	{ "name": "ap_return_17", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_17", "role": "default" }} , 
 	{ "name": "ap_return_18", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_18", "role": "default" }} , 
 	{ "name": "ap_return_19", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_19", "role": "default" }} , 
 	{ "name": "ap_return_20", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_20", "role": "default" }} , 
 	{ "name": "ap_return_21", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_21", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
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
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	ctx_layer_stamp_read_5 { ap_none {  { ctx_layer_stamp_read_5 in_data 0 32 } } }
	ctx_layer_stamp_read { ap_none {  { ctx_layer_stamp_read in_data 0 32 } } }
	ctx_phase_read { ap_none {  { ctx_phase_read in_data 0 4 } } }
	ctx_compute_ready_read { ap_none {  { ctx_compute_ready_read in_data 0 1 } } }
	ctx_compute_done_read { ap_none {  { ctx_compute_done_read in_data 0 1 } } }
	ctx_compute_op_read { ap_none {  { ctx_compute_op_read in_data 0 4 } } }
	ctx_start_head_read { ap_none {  { ctx_start_head_read in_data 0 1 } } }
	ctx_q_started_read { ap_none {  { ctx_q_started_read in_data 0 1 } } }
	ctx_k_started_read { ap_none {  { ctx_k_started_read in_data 0 1 } } }
	ctx_v_started_read { ap_none {  { ctx_v_started_read in_data 0 1 } } }
	ctx_att_scores_started_read { ap_none {  { ctx_att_scores_started_read in_data 0 1 } } }
	ctx_val_scale_started_read { ap_none {  { ctx_val_scale_started_read in_data 0 1 } } }
	ctx_softmax_started_read { ap_none {  { ctx_softmax_started_read in_data 0 1 } } }
	ctx_att_value_started_read { ap_none {  { ctx_att_value_started_read in_data 0 1 } } }
	ctx_q_compute_done_read { ap_none {  { ctx_q_compute_done_read in_data 0 1 } } }
	ctx_k_compute_done_read { ap_none {  { ctx_k_compute_done_read in_data 0 1 } } }
	ctx_v_compute_done_read { ap_none {  { ctx_v_compute_done_read in_data 0 1 } } }
	ctx_att_scores_compute_done_read { ap_none {  { ctx_att_scores_compute_done_read in_data 0 1 } } }
	ctx_val_scale_compute_done_read { ap_none {  { ctx_val_scale_compute_done_read in_data 0 1 } } }
	ctx_softmax_compute_done_read { ap_none {  { ctx_softmax_compute_done_read in_data 0 1 } } }
	ctx_att_value_compute_done_read { ap_none {  { ctx_att_value_compute_done_read in_data 0 1 } } }
	layer_idx { ap_none {  { layer_idx in_data 0 32 } } }
	start_r { ap_none {  { start_r in_data 0 1 } } }
}
