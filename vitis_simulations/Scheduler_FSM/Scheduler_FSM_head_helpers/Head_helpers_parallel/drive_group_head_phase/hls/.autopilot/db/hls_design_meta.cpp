#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_start", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_done", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_idle", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_ready", 1, hls_out, -1, "", "", 1),
	Port_Property("head_ctx_ref_0_i", 66, hls_in, 0, "ap_ovld", "in_data", 1),
	Port_Property("head_ctx_ref_0_o", 66, hls_out, 0, "ap_ovld", "out_data", 1),
	Port_Property("head_ctx_ref_0_o_ap_vld", 1, hls_out, 0, "ap_ovld", "out_vld", 1),
	Port_Property("head_ctx_ref_1_i", 66, hls_in, 1, "ap_ovld", "in_data", 1),
	Port_Property("head_ctx_ref_1_o", 66, hls_out, 1, "ap_ovld", "out_data", 1),
	Port_Property("head_ctx_ref_1_o_ap_vld", 1, hls_out, 1, "ap_ovld", "out_vld", 1),
	Port_Property("group_idx", 32, hls_in, 2, "ap_none", "in_data", 1),
	Port_Property("layer_idx", 32, hls_in, 3, "ap_none", "in_data", 1),
	Port_Property("start_r", 1, hls_in, 4, "ap_none", "in_data", 1),
	Port_Property("ap_return", 1, hls_out, -1, "", "", 1),
};
const char* HLS_Design_Meta::dut_name = "drive_group_head_phase";
