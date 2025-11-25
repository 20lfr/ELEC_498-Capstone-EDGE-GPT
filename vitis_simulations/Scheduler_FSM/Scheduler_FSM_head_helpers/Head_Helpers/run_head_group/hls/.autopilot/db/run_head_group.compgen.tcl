# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler run_head_group_sparsemux_7_2_1_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {onehotencoding_realdef}
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 3 \
    name head_ctx_ref \
    reset_level 1 \
    sync_rst true \
    dir IO \
    corename head_ctx_ref \
    op interface \
    ports { head_ctx_ref_address0 { O 3 vector } head_ctx_ref_ce0 { O 1 bit } head_ctx_ref_we0 { O 1 bit } head_ctx_ref_d0 { O 46 vector } head_ctx_ref_q0 { I 46 vector } head_ctx_ref_address1 { O 3 vector } head_ctx_ref_ce1 { O 1 bit } head_ctx_ref_we1 { O 1 bit } head_ctx_ref_d1 { O 46 vector } head_ctx_ref_q1 { I 46 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'head_ctx_ref'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name res \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_res \
    op interface \
    ports { res_i { I 140 vector } res_o { O 140 vector } res_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name layer_idx \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_layer_idx \
    op interface \
    ports { layer_idx { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name group_idx \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_group_idx \
    op interface \
    ports { group_idx { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
    name reset_resources \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_reset_resources \
    op interface \
    ports { reset_resources { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 8 \
    name compute_ready \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_ready \
    op interface \
    ports { compute_ready { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
    name compute_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_done \
    op interface \
    ports { compute_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10 \
    name wl_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_start \
    op interface \
    ports { wl_start { O 1 vector } wl_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 11 \
    name wl_addr_sel \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_addr_sel \
    op interface \
    ports { wl_addr_sel { O 32 vector } wl_addr_sel_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 12 \
    name wl_layer \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_layer \
    op interface \
    ports { wl_layer { O 32 vector } wl_layer_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 13 \
    name wl_head \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_head \
    op interface \
    ports { wl_head { O 32 vector } wl_head_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 14 \
    name wl_tile \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_tile \
    op interface \
    ports { wl_tile { O 32 vector } wl_tile_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 15 \
    name compute_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_start \
    op interface \
    ports { compute_start { O 1 vector } compute_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 16 \
    name compute_op \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_op \
    op interface \
    ports { compute_op { O 32 vector } compute_op_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 17 \
    name requant_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_requant_start \
    op interface \
    ports { requant_start { O 1 vector } requant_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 18 \
    name requant_op \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_requant_op \
    op interface \
    ports { requant_op { O 32 vector } requant_op_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -2 \
    name ap_return \
    type ap_return \
    reset_level 1 \
    sync_rst true \
    corename ap_return \
    op interface \
    ports { ap_return { O 1 vector } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -4 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


