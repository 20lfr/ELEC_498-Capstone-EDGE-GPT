#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_start", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_done", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_idle", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_ready", 1, hls_out, -1, "", "", 1),
	Port_Property("mem_i", 864, hls_in, 0, "ap_ovld", "in_data", 1),
	Port_Property("mem_o", 864, hls_out, 0, "ap_ovld", "out_data", 1),
	Port_Property("mem_o_ap_vld", 1, hls_out, 0, "ap_ovld", "out_vld", 1),
	Port_Property("address", 32, hls_in, 1, "ap_none", "in_data", 1),
	Port_Property("data_in", 32, hls_in, 2, "ap_none", "in_data", 1),
	Port_Property("data_out", 32, hls_out, 3, "ap_vld", "out_data", 1),
	Port_Property("data_out_ap_vld", 1, hls_out, 3, "ap_vld", "out_vld", 1),
	Port_Property("read_control", 1, hls_in, 4, "ap_none", "in_data", 1),
	Port_Property("write_control", 1, hls_in, 5, "ap_none", "in_data", 1),
	Port_Property("chip_enable", 1, hls_in, 6, "ap_none", "in_data", 1),
	Port_Property("reset_n", 1, hls_in, 7, "ap_none", "in_data", 1),
	Port_Property("ap_rst", 1, hls_in, -1, "", "", 1),
};
const char* HLS_Design_Meta::dut_name = "ControlMemInterface";
