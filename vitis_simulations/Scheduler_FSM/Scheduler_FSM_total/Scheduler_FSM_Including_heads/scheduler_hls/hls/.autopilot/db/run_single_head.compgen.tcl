# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 1 \
    name ctx_layer_stamp_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_layer_stamp_read \
    op interface \
    ports { ctx_layer_stamp_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2 \
    name ctx_phase_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_phase_read \
    op interface \
    ports { ctx_phase_read { I 4 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 3 \
    name ctx_compute_ready_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_compute_ready_read \
    op interface \
    ports { ctx_compute_ready_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name ctx_compute_done_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_compute_done_read \
    op interface \
    ports { ctx_compute_done_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name ctx_compute_op_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_compute_op_read \
    op interface \
    ports { ctx_compute_op_read { I 5 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name ctx_start_head_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_start_head_read \
    op interface \
    ports { ctx_start_head_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
    name ctx_q_started_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_q_started_read \
    op interface \
    ports { ctx_q_started_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 8 \
    name ctx_k_started_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_k_started_read \
    op interface \
    ports { ctx_k_started_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
    name ctx_v_started_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_v_started_read \
    op interface \
    ports { ctx_v_started_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10 \
    name ctx_att_scores_started_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_att_scores_started_read \
    op interface \
    ports { ctx_att_scores_started_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 11 \
    name ctx_val_scale_started_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_val_scale_started_read \
    op interface \
    ports { ctx_val_scale_started_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 12 \
    name ctx_softmax_started_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_softmax_started_read \
    op interface \
    ports { ctx_softmax_started_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 13 \
    name ctx_att_value_started_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_att_value_started_read \
    op interface \
    ports { ctx_att_value_started_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 14 \
    name ctx_q_compute_done_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_q_compute_done_read \
    op interface \
    ports { ctx_q_compute_done_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 15 \
    name ctx_k_compute_done_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_k_compute_done_read \
    op interface \
    ports { ctx_k_compute_done_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 16 \
    name ctx_v_compute_done_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_v_compute_done_read \
    op interface \
    ports { ctx_v_compute_done_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 17 \
    name ctx_att_scores_compute_done_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_att_scores_compute_done_read \
    op interface \
    ports { ctx_att_scores_compute_done_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 18 \
    name ctx_val_scale_compute_done_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_val_scale_compute_done_read \
    op interface \
    ports { ctx_val_scale_compute_done_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 19 \
    name ctx_softmax_compute_done_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_softmax_compute_done_read \
    op interface \
    ports { ctx_softmax_compute_done_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 20 \
    name ctx_att_value_compute_done_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_att_value_compute_done_read \
    op interface \
    ports { ctx_att_value_compute_done_read { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 21 \
    name ctx_layer_stamp_write \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctx_layer_stamp_write \
    op interface \
    ports { ctx_layer_stamp_write { I 32 vector } } \
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
    ports { ap_ready { O 1 bit } } \
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


