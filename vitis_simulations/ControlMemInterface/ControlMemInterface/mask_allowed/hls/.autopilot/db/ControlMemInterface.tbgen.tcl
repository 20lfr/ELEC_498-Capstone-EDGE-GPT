set moduleName ControlMemInterface
set isTopModule 1
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
set cdfgNum 2
set C_modelName {ControlMemInterface}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ mem int 864 regular {pointer 2}  }
	{ address int 32 regular  }
	{ data_in int 32 regular  }
	{ data_out int 32 regular {pointer 1}  }
	{ read_control uint 1 regular  }
	{ write_control uint 1 regular  }
	{ chip_enable uint 1 regular  }
	{ reset_n uint 1 regular  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "mem", "interface" : "wire", "bitwidth" : 864, "direction" : "READWRITE"} , 
 	{ "Name" : "address", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "data_in", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "data_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "read_control", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "write_control", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "chip_enable", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "reset_n", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 16
set portList { 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ mem_i sc_in sc_lv 864 signal 0 } 
	{ mem_o sc_out sc_lv 864 signal 0 } 
	{ mem_o_ap_vld sc_out sc_logic 1 outvld 0 } 
	{ address sc_in sc_lv 32 signal 1 } 
	{ data_in sc_in sc_lv 32 signal 2 } 
	{ data_out sc_out sc_lv 32 signal 3 } 
	{ data_out_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ read_control sc_in sc_lv 1 signal 4 } 
	{ write_control sc_in sc_lv 1 signal 5 } 
	{ chip_enable sc_in sc_lv 1 signal 6 } 
	{ reset_n sc_in sc_lv 1 signal 7 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
}
set NewPortList {[ 
	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "mem_i", "direction": "in", "datatype": "sc_lv", "bitwidth":864, "type": "signal", "bundle":{"name": "mem", "role": "i" }} , 
 	{ "name": "mem_o", "direction": "out", "datatype": "sc_lv", "bitwidth":864, "type": "signal", "bundle":{"name": "mem", "role": "o" }} , 
 	{ "name": "mem_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem", "role": "o_ap_vld" }} , 
 	{ "name": "address", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "address", "role": "default" }} , 
 	{ "name": "data_in", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "data_in", "role": "default" }} , 
 	{ "name": "data_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "data_out", "role": "default" }} , 
 	{ "name": "data_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "data_out", "role": "ap_vld" }} , 
 	{ "name": "read_control", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "read_control", "role": "default" }} , 
 	{ "name": "write_control", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "write_control", "role": "default" }} , 
 	{ "name": "chip_enable", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "chip_enable", "role": "default" }} , 
 	{ "name": "reset_n", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "reset_n", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	ControlMemInterface {
		mem {Type IO LastRead 0 FirstWrite 0}
		address {Type I LastRead 0 FirstWrite -1}
		data_in {Type I LastRead 0 FirstWrite -1}
		data_out {Type O LastRead -1 FirstWrite 0}
		read_control {Type I LastRead 0 FirstWrite -1}
		write_control {Type I LastRead 0 FirstWrite -1}
		chip_enable {Type I LastRead 0 FirstWrite -1}
		reset_n {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	mem { ap_ovld {  { mem_i in_data 0 864 }  { mem_o out_data 1 864 }  { mem_o_ap_vld out_vld 1 1 } } }
	address { ap_none {  { address in_data 0 32 } } }
	data_in { ap_none {  { data_in in_data 0 32 } } }
	data_out { ap_vld {  { data_out out_data 1 32 }  { data_out_ap_vld out_vld 1 1 } } }
	read_control { ap_none {  { read_control in_data 0 1 } } }
	write_control { ap_none {  { write_control in_data 0 1 } } }
	chip_enable { ap_none {  { chip_enable in_data 0 1 } } }
	reset_n { ap_none {  { reset_n in_data 0 1 } } }
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
