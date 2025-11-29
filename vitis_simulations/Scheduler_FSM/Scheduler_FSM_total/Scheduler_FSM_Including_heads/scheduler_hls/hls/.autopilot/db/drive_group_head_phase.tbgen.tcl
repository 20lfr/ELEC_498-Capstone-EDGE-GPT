set moduleName drive_group_head_phase
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
set C_modelName {drive_group_head_phase}
set C_modelType { int 265 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ p_read int 32 regular  }
	{ p_read1 int 32 regular  }
	{ p_read2 int 32 regular  }
	{ p_read3 int 32 regular  }
	{ head_ctx_ref_phase_read int 4 regular  }
	{ head_ctx_ref_phase_read_7 int 4 regular  }
	{ head_ctx_ref_phase_read_8 int 4 regular  }
	{ head_ctx_ref_phase_read_9 int 4 regular  }
	{ p_read8 int 1 regular  }
	{ p_read9 int 1 regular  }
	{ p_read10 int 1 regular  }
	{ p_read11 int 1 regular  }
	{ p_read12 int 1 regular  }
	{ p_read13 int 1 regular  }
	{ p_read14 int 1 regular  }
	{ p_read15 int 1 regular  }
	{ p_read16 int 1 regular  }
	{ p_read17 int 1 regular  }
	{ p_read18 int 1 regular  }
	{ p_read19 int 1 regular  }
	{ head_ctx_ref_compute_op_read int 4 regular  }
	{ head_ctx_ref_compute_op_read_11 int 4 regular  }
	{ head_ctx_ref_compute_op_read_12 int 4 regular  }
	{ head_ctx_ref_compute_op_read_13 int 4 regular  }
	{ p_read24 int 1 regular  }
	{ p_read25 int 1 regular  }
	{ p_read26 int 1 regular  }
	{ p_read27 int 1 regular  }
	{ p_read28 int 1 regular  }
	{ p_read29 int 1 regular  }
	{ p_read30 int 1 regular  }
	{ p_read31 int 1 regular  }
	{ p_read32 int 1 regular  }
	{ p_read33 int 1 regular  }
	{ p_read34 int 1 regular  }
	{ p_read35 int 1 regular  }
	{ p_read36 int 1 regular  }
	{ p_read37 int 1 regular  }
	{ p_read38 int 1 regular  }
	{ p_read39 int 1 regular  }
	{ p_read40 int 1 regular  }
	{ p_read41 int 1 regular  }
	{ p_read42 int 1 regular  }
	{ p_read43 int 1 regular  }
	{ p_read44 int 1 regular  }
	{ p_read45 int 1 regular  }
	{ p_read46 int 1 regular  }
	{ p_read47 int 1 regular  }
	{ p_read48 int 1 regular  }
	{ p_read49 int 1 regular  }
	{ p_read50 int 1 regular  }
	{ p_read51 int 1 regular  }
	{ p_read52 int 1 regular  }
	{ p_read53 int 1 regular  }
	{ p_read54 int 1 regular  }
	{ p_read55 int 1 regular  }
	{ p_read56 int 1 regular  }
	{ p_read57 int 1 regular  }
	{ p_read58 int 1 regular  }
	{ p_read59 int 1 regular  }
	{ p_read60 int 1 regular  }
	{ p_read61 int 1 regular  }
	{ p_read62 int 1 regular  }
	{ p_read63 int 1 regular  }
	{ p_read64 int 1 regular  }
	{ p_read65 int 1 regular  }
	{ p_read66 int 1 regular  }
	{ p_read67 int 1 regular  }
	{ p_read68 int 1 regular  }
	{ p_read69 int 1 regular  }
	{ p_read70 int 1 regular  }
	{ p_read71 int 1 regular  }
	{ p_read72 int 1 regular  }
	{ p_read73 int 1 regular  }
	{ p_read74 int 1 regular  }
	{ p_read75 int 1 regular  }
	{ p_read76 int 1 regular  }
	{ p_read77 int 1 regular  }
	{ p_read78 int 1 regular  }
	{ p_read79 int 1 regular  }
	{ p_read80 int 1 regular  }
	{ p_read81 int 1 regular  }
	{ p_read82 int 1 regular  }
	{ p_read83 int 1 regular  }
	{ layer_idx int 32 regular  }
	{ start_r uint 1 regular  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "p_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read1", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read2", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_read3", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_phase_read", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_phase_read_7", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_phase_read_8", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_phase_read_9", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "p_read8", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read9", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read10", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read11", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read12", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read13", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read14", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read15", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read16", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read17", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read18", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read19", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_compute_op_read", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_compute_op_read_11", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_compute_op_read_12", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_compute_op_read_13", "interface" : "wire", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "p_read24", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read25", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read26", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read27", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read28", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read29", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read30", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read31", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read32", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read33", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read34", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read35", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read36", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read37", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read38", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read39", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read40", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read41", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read42", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read43", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read44", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read45", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read46", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read47", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read48", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read49", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read50", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read51", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read52", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read53", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read54", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read55", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read56", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read57", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read58", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read59", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read60", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read61", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read62", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read63", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read64", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read65", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read66", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read67", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read68", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read69", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read70", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read71", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read72", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read73", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read74", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read75", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read76", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read77", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read78", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read79", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read80", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read81", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read82", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "p_read83", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "layer_idx", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "start_r", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 265} ]}
# RTL Port declarations: 
set portNum 173
set portList { 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ p_read sc_in sc_lv 32 signal 0 } 
	{ p_read1 sc_in sc_lv 32 signal 1 } 
	{ p_read2 sc_in sc_lv 32 signal 2 } 
	{ p_read3 sc_in sc_lv 32 signal 3 } 
	{ head_ctx_ref_phase_read sc_in sc_lv 4 signal 4 } 
	{ head_ctx_ref_phase_read_7 sc_in sc_lv 4 signal 5 } 
	{ head_ctx_ref_phase_read_8 sc_in sc_lv 4 signal 6 } 
	{ head_ctx_ref_phase_read_9 sc_in sc_lv 4 signal 7 } 
	{ p_read8 sc_in sc_lv 1 signal 8 } 
	{ p_read9 sc_in sc_lv 1 signal 9 } 
	{ p_read10 sc_in sc_lv 1 signal 10 } 
	{ p_read11 sc_in sc_lv 1 signal 11 } 
	{ p_read12 sc_in sc_lv 1 signal 12 } 
	{ p_read13 sc_in sc_lv 1 signal 13 } 
	{ p_read14 sc_in sc_lv 1 signal 14 } 
	{ p_read15 sc_in sc_lv 1 signal 15 } 
	{ p_read16 sc_in sc_lv 1 signal 16 } 
	{ p_read17 sc_in sc_lv 1 signal 17 } 
	{ p_read18 sc_in sc_lv 1 signal 18 } 
	{ p_read19 sc_in sc_lv 1 signal 19 } 
	{ head_ctx_ref_compute_op_read sc_in sc_lv 4 signal 20 } 
	{ head_ctx_ref_compute_op_read_11 sc_in sc_lv 4 signal 21 } 
	{ head_ctx_ref_compute_op_read_12 sc_in sc_lv 4 signal 22 } 
	{ head_ctx_ref_compute_op_read_13 sc_in sc_lv 4 signal 23 } 
	{ p_read24 sc_in sc_lv 1 signal 24 } 
	{ p_read25 sc_in sc_lv 1 signal 25 } 
	{ p_read26 sc_in sc_lv 1 signal 26 } 
	{ p_read27 sc_in sc_lv 1 signal 27 } 
	{ p_read28 sc_in sc_lv 1 signal 28 } 
	{ p_read29 sc_in sc_lv 1 signal 29 } 
	{ p_read30 sc_in sc_lv 1 signal 30 } 
	{ p_read31 sc_in sc_lv 1 signal 31 } 
	{ p_read32 sc_in sc_lv 1 signal 32 } 
	{ p_read33 sc_in sc_lv 1 signal 33 } 
	{ p_read34 sc_in sc_lv 1 signal 34 } 
	{ p_read35 sc_in sc_lv 1 signal 35 } 
	{ p_read36 sc_in sc_lv 1 signal 36 } 
	{ p_read37 sc_in sc_lv 1 signal 37 } 
	{ p_read38 sc_in sc_lv 1 signal 38 } 
	{ p_read39 sc_in sc_lv 1 signal 39 } 
	{ p_read40 sc_in sc_lv 1 signal 40 } 
	{ p_read41 sc_in sc_lv 1 signal 41 } 
	{ p_read42 sc_in sc_lv 1 signal 42 } 
	{ p_read43 sc_in sc_lv 1 signal 43 } 
	{ p_read44 sc_in sc_lv 1 signal 44 } 
	{ p_read45 sc_in sc_lv 1 signal 45 } 
	{ p_read46 sc_in sc_lv 1 signal 46 } 
	{ p_read47 sc_in sc_lv 1 signal 47 } 
	{ p_read48 sc_in sc_lv 1 signal 48 } 
	{ p_read49 sc_in sc_lv 1 signal 49 } 
	{ p_read50 sc_in sc_lv 1 signal 50 } 
	{ p_read51 sc_in sc_lv 1 signal 51 } 
	{ p_read52 sc_in sc_lv 1 signal 52 } 
	{ p_read53 sc_in sc_lv 1 signal 53 } 
	{ p_read54 sc_in sc_lv 1 signal 54 } 
	{ p_read55 sc_in sc_lv 1 signal 55 } 
	{ p_read56 sc_in sc_lv 1 signal 56 } 
	{ p_read57 sc_in sc_lv 1 signal 57 } 
	{ p_read58 sc_in sc_lv 1 signal 58 } 
	{ p_read59 sc_in sc_lv 1 signal 59 } 
	{ p_read60 sc_in sc_lv 1 signal 60 } 
	{ p_read61 sc_in sc_lv 1 signal 61 } 
	{ p_read62 sc_in sc_lv 1 signal 62 } 
	{ p_read63 sc_in sc_lv 1 signal 63 } 
	{ p_read64 sc_in sc_lv 1 signal 64 } 
	{ p_read65 sc_in sc_lv 1 signal 65 } 
	{ p_read66 sc_in sc_lv 1 signal 66 } 
	{ p_read67 sc_in sc_lv 1 signal 67 } 
	{ p_read68 sc_in sc_lv 1 signal 68 } 
	{ p_read69 sc_in sc_lv 1 signal 69 } 
	{ p_read70 sc_in sc_lv 1 signal 70 } 
	{ p_read71 sc_in sc_lv 1 signal 71 } 
	{ p_read72 sc_in sc_lv 1 signal 72 } 
	{ p_read73 sc_in sc_lv 1 signal 73 } 
	{ p_read74 sc_in sc_lv 1 signal 74 } 
	{ p_read75 sc_in sc_lv 1 signal 75 } 
	{ p_read76 sc_in sc_lv 1 signal 76 } 
	{ p_read77 sc_in sc_lv 1 signal 77 } 
	{ p_read78 sc_in sc_lv 1 signal 78 } 
	{ p_read79 sc_in sc_lv 1 signal 79 } 
	{ p_read80 sc_in sc_lv 1 signal 80 } 
	{ p_read81 sc_in sc_lv 1 signal 81 } 
	{ p_read82 sc_in sc_lv 1 signal 82 } 
	{ p_read83 sc_in sc_lv 1 signal 83 } 
	{ layer_idx sc_in sc_lv 32 signal 84 } 
	{ start_r sc_in sc_lv 1 signal 85 } 
	{ ap_return_0 sc_out sc_lv 1 signal -1 } 
	{ ap_return_1 sc_out sc_lv 8 signal -1 } 
	{ ap_return_2 sc_out sc_lv 8 signal -1 } 
	{ ap_return_3 sc_out sc_lv 8 signal -1 } 
	{ ap_return_4 sc_out sc_lv 8 signal -1 } 
	{ ap_return_5 sc_out sc_lv 1 signal -1 } 
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
	{ ap_return_17 sc_out sc_lv 8 signal -1 } 
	{ ap_return_18 sc_out sc_lv 8 signal -1 } 
	{ ap_return_19 sc_out sc_lv 8 signal -1 } 
	{ ap_return_20 sc_out sc_lv 8 signal -1 } 
	{ ap_return_21 sc_out sc_lv 1 signal -1 } 
	{ ap_return_22 sc_out sc_lv 1 signal -1 } 
	{ ap_return_23 sc_out sc_lv 1 signal -1 } 
	{ ap_return_24 sc_out sc_lv 1 signal -1 } 
	{ ap_return_25 sc_out sc_lv 1 signal -1 } 
	{ ap_return_26 sc_out sc_lv 1 signal -1 } 
	{ ap_return_27 sc_out sc_lv 1 signal -1 } 
	{ ap_return_28 sc_out sc_lv 1 signal -1 } 
	{ ap_return_29 sc_out sc_lv 1 signal -1 } 
	{ ap_return_30 sc_out sc_lv 1 signal -1 } 
	{ ap_return_31 sc_out sc_lv 1 signal -1 } 
	{ ap_return_32 sc_out sc_lv 1 signal -1 } 
	{ ap_return_33 sc_out sc_lv 1 signal -1 } 
	{ ap_return_34 sc_out sc_lv 1 signal -1 } 
	{ ap_return_35 sc_out sc_lv 1 signal -1 } 
	{ ap_return_36 sc_out sc_lv 1 signal -1 } 
	{ ap_return_37 sc_out sc_lv 1 signal -1 } 
	{ ap_return_38 sc_out sc_lv 1 signal -1 } 
	{ ap_return_39 sc_out sc_lv 1 signal -1 } 
	{ ap_return_40 sc_out sc_lv 1 signal -1 } 
	{ ap_return_41 sc_out sc_lv 1 signal -1 } 
	{ ap_return_42 sc_out sc_lv 1 signal -1 } 
	{ ap_return_43 sc_out sc_lv 1 signal -1 } 
	{ ap_return_44 sc_out sc_lv 1 signal -1 } 
	{ ap_return_45 sc_out sc_lv 1 signal -1 } 
	{ ap_return_46 sc_out sc_lv 1 signal -1 } 
	{ ap_return_47 sc_out sc_lv 1 signal -1 } 
	{ ap_return_48 sc_out sc_lv 1 signal -1 } 
	{ ap_return_49 sc_out sc_lv 1 signal -1 } 
	{ ap_return_50 sc_out sc_lv 1 signal -1 } 
	{ ap_return_51 sc_out sc_lv 1 signal -1 } 
	{ ap_return_52 sc_out sc_lv 1 signal -1 } 
	{ ap_return_53 sc_out sc_lv 1 signal -1 } 
	{ ap_return_54 sc_out sc_lv 1 signal -1 } 
	{ ap_return_55 sc_out sc_lv 1 signal -1 } 
	{ ap_return_56 sc_out sc_lv 1 signal -1 } 
	{ ap_return_57 sc_out sc_lv 1 signal -1 } 
	{ ap_return_58 sc_out sc_lv 1 signal -1 } 
	{ ap_return_59 sc_out sc_lv 1 signal -1 } 
	{ ap_return_60 sc_out sc_lv 1 signal -1 } 
	{ ap_return_61 sc_out sc_lv 1 signal -1 } 
	{ ap_return_62 sc_out sc_lv 1 signal -1 } 
	{ ap_return_63 sc_out sc_lv 1 signal -1 } 
	{ ap_return_64 sc_out sc_lv 1 signal -1 } 
	{ ap_return_65 sc_out sc_lv 1 signal -1 } 
	{ ap_return_66 sc_out sc_lv 1 signal -1 } 
	{ ap_return_67 sc_out sc_lv 1 signal -1 } 
	{ ap_return_68 sc_out sc_lv 1 signal -1 } 
	{ ap_return_69 sc_out sc_lv 1 signal -1 } 
	{ ap_return_70 sc_out sc_lv 1 signal -1 } 
	{ ap_return_71 sc_out sc_lv 1 signal -1 } 
	{ ap_return_72 sc_out sc_lv 1 signal -1 } 
	{ ap_return_73 sc_out sc_lv 1 signal -1 } 
	{ ap_return_74 sc_out sc_lv 1 signal -1 } 
	{ ap_return_75 sc_out sc_lv 1 signal -1 } 
	{ ap_return_76 sc_out sc_lv 1 signal -1 } 
	{ ap_return_77 sc_out sc_lv 1 signal -1 } 
	{ ap_return_78 sc_out sc_lv 1 signal -1 } 
	{ ap_return_79 sc_out sc_lv 1 signal -1 } 
	{ ap_return_80 sc_out sc_lv 1 signal -1 } 
	{ ap_return_81 sc_out sc_lv 32 signal -1 } 
	{ ap_return_82 sc_out sc_lv 32 signal -1 } 
	{ ap_return_83 sc_out sc_lv 32 signal -1 } 
	{ ap_return_84 sc_out sc_lv 32 signal -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
}
set NewPortList {[ 
	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "p_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read", "role": "default" }} , 
 	{ "name": "p_read1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read1", "role": "default" }} , 
 	{ "name": "p_read2", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read2", "role": "default" }} , 
 	{ "name": "p_read3", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_read3", "role": "default" }} , 
 	{ "name": "head_ctx_ref_phase_read", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_phase_read", "role": "default" }} , 
 	{ "name": "head_ctx_ref_phase_read_7", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_phase_read_7", "role": "default" }} , 
 	{ "name": "head_ctx_ref_phase_read_8", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_phase_read_8", "role": "default" }} , 
 	{ "name": "head_ctx_ref_phase_read_9", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_phase_read_9", "role": "default" }} , 
 	{ "name": "p_read8", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read8", "role": "default" }} , 
 	{ "name": "p_read9", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read9", "role": "default" }} , 
 	{ "name": "p_read10", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read10", "role": "default" }} , 
 	{ "name": "p_read11", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read11", "role": "default" }} , 
 	{ "name": "p_read12", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read12", "role": "default" }} , 
 	{ "name": "p_read13", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read13", "role": "default" }} , 
 	{ "name": "p_read14", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read14", "role": "default" }} , 
 	{ "name": "p_read15", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read15", "role": "default" }} , 
 	{ "name": "p_read16", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read16", "role": "default" }} , 
 	{ "name": "p_read17", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read17", "role": "default" }} , 
 	{ "name": "p_read18", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read18", "role": "default" }} , 
 	{ "name": "p_read19", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read19", "role": "default" }} , 
 	{ "name": "head_ctx_ref_compute_op_read", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_compute_op_read", "role": "default" }} , 
 	{ "name": "head_ctx_ref_compute_op_read_11", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_compute_op_read_11", "role": "default" }} , 
 	{ "name": "head_ctx_ref_compute_op_read_12", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_compute_op_read_12", "role": "default" }} , 
 	{ "name": "head_ctx_ref_compute_op_read_13", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "head_ctx_ref_compute_op_read_13", "role": "default" }} , 
 	{ "name": "p_read24", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read24", "role": "default" }} , 
 	{ "name": "p_read25", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read25", "role": "default" }} , 
 	{ "name": "p_read26", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read26", "role": "default" }} , 
 	{ "name": "p_read27", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read27", "role": "default" }} , 
 	{ "name": "p_read28", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read28", "role": "default" }} , 
 	{ "name": "p_read29", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read29", "role": "default" }} , 
 	{ "name": "p_read30", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read30", "role": "default" }} , 
 	{ "name": "p_read31", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read31", "role": "default" }} , 
 	{ "name": "p_read32", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read32", "role": "default" }} , 
 	{ "name": "p_read33", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read33", "role": "default" }} , 
 	{ "name": "p_read34", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read34", "role": "default" }} , 
 	{ "name": "p_read35", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read35", "role": "default" }} , 
 	{ "name": "p_read36", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read36", "role": "default" }} , 
 	{ "name": "p_read37", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read37", "role": "default" }} , 
 	{ "name": "p_read38", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read38", "role": "default" }} , 
 	{ "name": "p_read39", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read39", "role": "default" }} , 
 	{ "name": "p_read40", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read40", "role": "default" }} , 
 	{ "name": "p_read41", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read41", "role": "default" }} , 
 	{ "name": "p_read42", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read42", "role": "default" }} , 
 	{ "name": "p_read43", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read43", "role": "default" }} , 
 	{ "name": "p_read44", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read44", "role": "default" }} , 
 	{ "name": "p_read45", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read45", "role": "default" }} , 
 	{ "name": "p_read46", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read46", "role": "default" }} , 
 	{ "name": "p_read47", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read47", "role": "default" }} , 
 	{ "name": "p_read48", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read48", "role": "default" }} , 
 	{ "name": "p_read49", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read49", "role": "default" }} , 
 	{ "name": "p_read50", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read50", "role": "default" }} , 
 	{ "name": "p_read51", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read51", "role": "default" }} , 
 	{ "name": "p_read52", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read52", "role": "default" }} , 
 	{ "name": "p_read53", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read53", "role": "default" }} , 
 	{ "name": "p_read54", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read54", "role": "default" }} , 
 	{ "name": "p_read55", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read55", "role": "default" }} , 
 	{ "name": "p_read56", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read56", "role": "default" }} , 
 	{ "name": "p_read57", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read57", "role": "default" }} , 
 	{ "name": "p_read58", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read58", "role": "default" }} , 
 	{ "name": "p_read59", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read59", "role": "default" }} , 
 	{ "name": "p_read60", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read60", "role": "default" }} , 
 	{ "name": "p_read61", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read61", "role": "default" }} , 
 	{ "name": "p_read62", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read62", "role": "default" }} , 
 	{ "name": "p_read63", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read63", "role": "default" }} , 
 	{ "name": "p_read64", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read64", "role": "default" }} , 
 	{ "name": "p_read65", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read65", "role": "default" }} , 
 	{ "name": "p_read66", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read66", "role": "default" }} , 
 	{ "name": "p_read67", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read67", "role": "default" }} , 
 	{ "name": "p_read68", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read68", "role": "default" }} , 
 	{ "name": "p_read69", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read69", "role": "default" }} , 
 	{ "name": "p_read70", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read70", "role": "default" }} , 
 	{ "name": "p_read71", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read71", "role": "default" }} , 
 	{ "name": "p_read72", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read72", "role": "default" }} , 
 	{ "name": "p_read73", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read73", "role": "default" }} , 
 	{ "name": "p_read74", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read74", "role": "default" }} , 
 	{ "name": "p_read75", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read75", "role": "default" }} , 
 	{ "name": "p_read76", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read76", "role": "default" }} , 
 	{ "name": "p_read77", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read77", "role": "default" }} , 
 	{ "name": "p_read78", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read78", "role": "default" }} , 
 	{ "name": "p_read79", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read79", "role": "default" }} , 
 	{ "name": "p_read80", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read80", "role": "default" }} , 
 	{ "name": "p_read81", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read81", "role": "default" }} , 
 	{ "name": "p_read82", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read82", "role": "default" }} , 
 	{ "name": "p_read83", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "p_read83", "role": "default" }} , 
 	{ "name": "layer_idx", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layer_idx", "role": "default" }} , 
 	{ "name": "start_r", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "start_r", "role": "default" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }} , 
 	{ "name": "ap_return_3", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_3", "role": "default" }} , 
 	{ "name": "ap_return_4", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_4", "role": "default" }} , 
 	{ "name": "ap_return_5", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_5", "role": "default" }} , 
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
 	{ "name": "ap_return_17", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_17", "role": "default" }} , 
 	{ "name": "ap_return_18", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_18", "role": "default" }} , 
 	{ "name": "ap_return_19", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_19", "role": "default" }} , 
 	{ "name": "ap_return_20", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "ap_return_20", "role": "default" }} , 
 	{ "name": "ap_return_21", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_21", "role": "default" }} , 
 	{ "name": "ap_return_22", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_22", "role": "default" }} , 
 	{ "name": "ap_return_23", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_23", "role": "default" }} , 
 	{ "name": "ap_return_24", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_24", "role": "default" }} , 
 	{ "name": "ap_return_25", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_25", "role": "default" }} , 
 	{ "name": "ap_return_26", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_26", "role": "default" }} , 
 	{ "name": "ap_return_27", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_27", "role": "default" }} , 
 	{ "name": "ap_return_28", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_28", "role": "default" }} , 
 	{ "name": "ap_return_29", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_29", "role": "default" }} , 
 	{ "name": "ap_return_30", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_30", "role": "default" }} , 
 	{ "name": "ap_return_31", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_31", "role": "default" }} , 
 	{ "name": "ap_return_32", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_32", "role": "default" }} , 
 	{ "name": "ap_return_33", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_33", "role": "default" }} , 
 	{ "name": "ap_return_34", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_34", "role": "default" }} , 
 	{ "name": "ap_return_35", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_35", "role": "default" }} , 
 	{ "name": "ap_return_36", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_36", "role": "default" }} , 
 	{ "name": "ap_return_37", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_37", "role": "default" }} , 
 	{ "name": "ap_return_38", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_38", "role": "default" }} , 
 	{ "name": "ap_return_39", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_39", "role": "default" }} , 
 	{ "name": "ap_return_40", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_40", "role": "default" }} , 
 	{ "name": "ap_return_41", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_41", "role": "default" }} , 
 	{ "name": "ap_return_42", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_42", "role": "default" }} , 
 	{ "name": "ap_return_43", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_43", "role": "default" }} , 
 	{ "name": "ap_return_44", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_44", "role": "default" }} , 
 	{ "name": "ap_return_45", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_45", "role": "default" }} , 
 	{ "name": "ap_return_46", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_46", "role": "default" }} , 
 	{ "name": "ap_return_47", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_47", "role": "default" }} , 
 	{ "name": "ap_return_48", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_48", "role": "default" }} , 
 	{ "name": "ap_return_49", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_49", "role": "default" }} , 
 	{ "name": "ap_return_50", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_50", "role": "default" }} , 
 	{ "name": "ap_return_51", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_51", "role": "default" }} , 
 	{ "name": "ap_return_52", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_52", "role": "default" }} , 
 	{ "name": "ap_return_53", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_53", "role": "default" }} , 
 	{ "name": "ap_return_54", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_54", "role": "default" }} , 
 	{ "name": "ap_return_55", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_55", "role": "default" }} , 
 	{ "name": "ap_return_56", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_56", "role": "default" }} , 
 	{ "name": "ap_return_57", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_57", "role": "default" }} , 
 	{ "name": "ap_return_58", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_58", "role": "default" }} , 
 	{ "name": "ap_return_59", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_59", "role": "default" }} , 
 	{ "name": "ap_return_60", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_60", "role": "default" }} , 
 	{ "name": "ap_return_61", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_61", "role": "default" }} , 
 	{ "name": "ap_return_62", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_62", "role": "default" }} , 
 	{ "name": "ap_return_63", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_63", "role": "default" }} , 
 	{ "name": "ap_return_64", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_64", "role": "default" }} , 
 	{ "name": "ap_return_65", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_65", "role": "default" }} , 
 	{ "name": "ap_return_66", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_66", "role": "default" }} , 
 	{ "name": "ap_return_67", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_67", "role": "default" }} , 
 	{ "name": "ap_return_68", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_68", "role": "default" }} , 
 	{ "name": "ap_return_69", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_69", "role": "default" }} , 
 	{ "name": "ap_return_70", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_70", "role": "default" }} , 
 	{ "name": "ap_return_71", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_71", "role": "default" }} , 
 	{ "name": "ap_return_72", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_72", "role": "default" }} , 
 	{ "name": "ap_return_73", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_73", "role": "default" }} , 
 	{ "name": "ap_return_74", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_74", "role": "default" }} , 
 	{ "name": "ap_return_75", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_75", "role": "default" }} , 
 	{ "name": "ap_return_76", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_76", "role": "default" }} , 
 	{ "name": "ap_return_77", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_77", "role": "default" }} , 
 	{ "name": "ap_return_78", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_78", "role": "default" }} , 
 	{ "name": "ap_return_79", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_79", "role": "default" }} , 
 	{ "name": "ap_return_80", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ap_return_80", "role": "default" }} , 
 	{ "name": "ap_return_81", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_81", "role": "default" }} , 
 	{ "name": "ap_return_82", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_82", "role": "default" }} , 
 	{ "name": "ap_return_83", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_83", "role": "default" }} , 
 	{ "name": "ap_return_84", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_84", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
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
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	p_read { ap_none {  { p_read in_data 0 32 } } }
	p_read1 { ap_none {  { p_read1 in_data 0 32 } } }
	p_read2 { ap_none {  { p_read2 in_data 0 32 } } }
	p_read3 { ap_none {  { p_read3 in_data 0 32 } } }
	head_ctx_ref_phase_read { ap_none {  { head_ctx_ref_phase_read in_data 0 4 } } }
	head_ctx_ref_phase_read_7 { ap_none {  { head_ctx_ref_phase_read_7 in_data 0 4 } } }
	head_ctx_ref_phase_read_8 { ap_none {  { head_ctx_ref_phase_read_8 in_data 0 4 } } }
	head_ctx_ref_phase_read_9 { ap_none {  { head_ctx_ref_phase_read_9 in_data 0 4 } } }
	p_read8 { ap_none {  { p_read8 in_data 0 1 } } }
	p_read9 { ap_none {  { p_read9 in_data 0 1 } } }
	p_read10 { ap_none {  { p_read10 in_data 0 1 } } }
	p_read11 { ap_none {  { p_read11 in_data 0 1 } } }
	p_read12 { ap_none {  { p_read12 in_data 0 1 } } }
	p_read13 { ap_none {  { p_read13 in_data 0 1 } } }
	p_read14 { ap_none {  { p_read14 in_data 0 1 } } }
	p_read15 { ap_none {  { p_read15 in_data 0 1 } } }
	p_read16 { ap_none {  { p_read16 in_data 0 1 } } }
	p_read17 { ap_none {  { p_read17 in_data 0 1 } } }
	p_read18 { ap_none {  { p_read18 in_data 0 1 } } }
	p_read19 { ap_none {  { p_read19 in_data 0 1 } } }
	head_ctx_ref_compute_op_read { ap_none {  { head_ctx_ref_compute_op_read in_data 0 4 } } }
	head_ctx_ref_compute_op_read_11 { ap_none {  { head_ctx_ref_compute_op_read_11 in_data 0 4 } } }
	head_ctx_ref_compute_op_read_12 { ap_none {  { head_ctx_ref_compute_op_read_12 in_data 0 4 } } }
	head_ctx_ref_compute_op_read_13 { ap_none {  { head_ctx_ref_compute_op_read_13 in_data 0 4 } } }
	p_read24 { ap_none {  { p_read24 in_data 0 1 } } }
	p_read25 { ap_none {  { p_read25 in_data 0 1 } } }
	p_read26 { ap_none {  { p_read26 in_data 0 1 } } }
	p_read27 { ap_none {  { p_read27 in_data 0 1 } } }
	p_read28 { ap_none {  { p_read28 in_data 0 1 } } }
	p_read29 { ap_none {  { p_read29 in_data 0 1 } } }
	p_read30 { ap_none {  { p_read30 in_data 0 1 } } }
	p_read31 { ap_none {  { p_read31 in_data 0 1 } } }
	p_read32 { ap_none {  { p_read32 in_data 0 1 } } }
	p_read33 { ap_none {  { p_read33 in_data 0 1 } } }
	p_read34 { ap_none {  { p_read34 in_data 0 1 } } }
	p_read35 { ap_none {  { p_read35 in_data 0 1 } } }
	p_read36 { ap_none {  { p_read36 in_data 0 1 } } }
	p_read37 { ap_none {  { p_read37 in_data 0 1 } } }
	p_read38 { ap_none {  { p_read38 in_data 0 1 } } }
	p_read39 { ap_none {  { p_read39 in_data 0 1 } } }
	p_read40 { ap_none {  { p_read40 in_data 0 1 } } }
	p_read41 { ap_none {  { p_read41 in_data 0 1 } } }
	p_read42 { ap_none {  { p_read42 in_data 0 1 } } }
	p_read43 { ap_none {  { p_read43 in_data 0 1 } } }
	p_read44 { ap_none {  { p_read44 in_data 0 1 } } }
	p_read45 { ap_none {  { p_read45 in_data 0 1 } } }
	p_read46 { ap_none {  { p_read46 in_data 0 1 } } }
	p_read47 { ap_none {  { p_read47 in_data 0 1 } } }
	p_read48 { ap_none {  { p_read48 in_data 0 1 } } }
	p_read49 { ap_none {  { p_read49 in_data 0 1 } } }
	p_read50 { ap_none {  { p_read50 in_data 0 1 } } }
	p_read51 { ap_none {  { p_read51 in_data 0 1 } } }
	p_read52 { ap_none {  { p_read52 in_data 0 1 } } }
	p_read53 { ap_none {  { p_read53 in_data 0 1 } } }
	p_read54 { ap_none {  { p_read54 in_data 0 1 } } }
	p_read55 { ap_none {  { p_read55 in_data 0 1 } } }
	p_read56 { ap_none {  { p_read56 in_data 0 1 } } }
	p_read57 { ap_none {  { p_read57 in_data 0 1 } } }
	p_read58 { ap_none {  { p_read58 in_data 0 1 } } }
	p_read59 { ap_none {  { p_read59 in_data 0 1 } } }
	p_read60 { ap_none {  { p_read60 in_data 0 1 } } }
	p_read61 { ap_none {  { p_read61 in_data 0 1 } } }
	p_read62 { ap_none {  { p_read62 in_data 0 1 } } }
	p_read63 { ap_none {  { p_read63 in_data 0 1 } } }
	p_read64 { ap_none {  { p_read64 in_data 0 1 } } }
	p_read65 { ap_none {  { p_read65 in_data 0 1 } } }
	p_read66 { ap_none {  { p_read66 in_data 0 1 } } }
	p_read67 { ap_none {  { p_read67 in_data 0 1 } } }
	p_read68 { ap_none {  { p_read68 in_data 0 1 } } }
	p_read69 { ap_none {  { p_read69 in_data 0 1 } } }
	p_read70 { ap_none {  { p_read70 in_data 0 1 } } }
	p_read71 { ap_none {  { p_read71 in_data 0 1 } } }
	p_read72 { ap_none {  { p_read72 in_data 0 1 } } }
	p_read73 { ap_none {  { p_read73 in_data 0 1 } } }
	p_read74 { ap_none {  { p_read74 in_data 0 1 } } }
	p_read75 { ap_none {  { p_read75 in_data 0 1 } } }
	p_read76 { ap_none {  { p_read76 in_data 0 1 } } }
	p_read77 { ap_none {  { p_read77 in_data 0 1 } } }
	p_read78 { ap_none {  { p_read78 in_data 0 1 } } }
	p_read79 { ap_none {  { p_read79 in_data 0 1 } } }
	p_read80 { ap_none {  { p_read80 in_data 0 1 } } }
	p_read81 { ap_none {  { p_read81 in_data 0 1 } } }
	p_read82 { ap_none {  { p_read82 in_data 0 1 } } }
	p_read83 { ap_none {  { p_read83 in_data 0 1 } } }
	layer_idx { ap_none {  { layer_idx in_data 0 32 } } }
	start_r { ap_none {  { start_r in_data 0 1 } } }
}
