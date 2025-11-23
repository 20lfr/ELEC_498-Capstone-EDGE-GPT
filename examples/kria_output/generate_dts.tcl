hsi open_hw_design "/home/tristan/development/edge_gpt/ELEC_498-Capstone-EDGE-GPT/examples/axi-stream-test-hw/system_wrapper.xsa"
hsi set_repo_path ./device-tree-xlnx
hsi create_sw_design device-tree -os device_tree -proc psu_cortexa53_0
hsi set_property CONFIG.dt_overlay true [hsi::get_os]
hsi set_property CONFIG.dt_zocl true [hsi::get_os]
hsi generate_target -dir ./dts_output
hsi close_hw_design [hsi current_hw_design]
exit
