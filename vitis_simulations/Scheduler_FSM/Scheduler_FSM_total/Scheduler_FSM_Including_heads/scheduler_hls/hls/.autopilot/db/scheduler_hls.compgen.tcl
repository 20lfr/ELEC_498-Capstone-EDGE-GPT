# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1 \
    name cntrl_start \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cntrl_start \
    op interface \
    ports { cntrl_start { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2 \
    name cntrl_reset_n \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cntrl_reset_n \
    op interface \
    ports { cntrl_reset_n { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 3 \
    name cntrl_layer_idx \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_cntrl_layer_idx \
    op interface \
    ports { cntrl_layer_idx { O 32 vector } cntrl_layer_idx_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name cntrl_busy \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_cntrl_busy \
    op interface \
    ports { cntrl_busy { O 1 vector } cntrl_busy_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name cntrl_start_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_cntrl_start_out \
    op interface \
    ports { cntrl_start_out { O 1 vector } cntrl_start_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name axis_in_valid \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_axis_in_valid \
    op interface \
    ports { axis_in_valid { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
    name axis_in_last \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_axis_in_last \
    op interface \
    ports { axis_in_last { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 8 \
    name axis_in_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_axis_in_ready \
    op interface \
    ports { axis_in_ready { O 1 vector } axis_in_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
    name wl_ready \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_ready \
    op interface \
    ports { wl_ready { I 1 vector } } \
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
    name dma_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_dma_done \
    op interface \
    ports { dma_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 16 \
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
    id 17 \
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
    id 18 \
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
    id 19 \
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
    id 20 \
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
    id 21 \
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
    id 22 \
    name stream_ready \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_stream_ready \
    op interface \
    ports { stream_ready { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 23 \
    name stream_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_stream_start \
    op interface \
    ports { stream_start { O 1 vector } stream_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 24 \
    name stream_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_stream_done \
    op interface \
    ports { stream_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 25 \
    name done \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_done \
    op interface \
    ports { done { O 1 vector } done_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 26 \
    name STATE \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_STATE \
    op interface \
    ports { STATE { O 32 vector } STATE_ap_vld { O 1 bit } } \
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


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
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
    id -3 \
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


