

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "drive_group_head_phase",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2", "EstimateLatencyMax" : "13",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "head_ctx_ref", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_run_single_head_fu_162", "Port" : "head_ctx_ref", "Inst_start_state" : "7", "Inst_end_state" : "8"}]},
			{"Name" : "group_idx", "Type" : "None", "Direction" : "I"},
			{"Name" : "layer_idx", "Type" : "None", "Direction" : "I"},
			{"Name" : "start_r", "Type" : "None", "Direction" : "I"},
			{"Name" : "Q_started", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_run_single_head_fu_162", "Port" : "Q_started", "Inst_start_state" : "7", "Inst_end_state" : "8"}]},
			{"Name" : "K_started", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_run_single_head_fu_162", "Port" : "K_started", "Inst_start_state" : "7", "Inst_end_state" : "8"}]},
			{"Name" : "V_started", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_run_single_head_fu_162", "Port" : "V_started", "Inst_start_state" : "7", "Inst_end_state" : "8"}]},
			{"Name" : "att_scores_started", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_run_single_head_fu_162", "Port" : "att_scores_started", "Inst_start_state" : "7", "Inst_end_state" : "8"}]},
			{"Name" : "val_scale_started", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_run_single_head_fu_162", "Port" : "val_scale_started", "Inst_start_state" : "7", "Inst_end_state" : "8"}]},
			{"Name" : "softmax_started", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_run_single_head_fu_162", "Port" : "softmax_started", "Inst_start_state" : "7", "Inst_end_state" : "8"}]},
			{"Name" : "att_value_started", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_run_single_head_fu_162", "Port" : "att_value_started", "Inst_start_state" : "7", "Inst_end_state" : "8"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_run_single_head_fu_162", "Parent" : "0",
		"CDFG" : "run_single_head",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "3", "EstimateLatencyMax" : "3",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "head_ctx_ref", "Type" : "Memory", "Direction" : "IO"},
			{"Name" : "ctx", "Type" : "None", "Direction" : "I"},
			{"Name" : "layer_idx", "Type" : "None", "Direction" : "I"},
			{"Name" : "start_r", "Type" : "None", "Direction" : "I"},
			{"Name" : "Q_started", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "K_started", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "V_started", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "att_scores_started", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "val_scale_started", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "softmax_started", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "att_value_started", "Type" : "OVld", "Direction" : "IO"}]}]}
