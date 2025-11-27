# 2025-11-26T13:26:29.906297
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_head_helpers")

comp = client.get_component(name="Head_Helpers_simplified")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp.run(operation="CO_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp = client.create_hls_component(name = "Head_Helpers_drive_parallel",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Head_Helpers_drive_parallel")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="SYNTHESIS")

client.delete_component(name="Head_Helpers_drive_parallel")

comp = client.create_hls_component(name = "Head_helpers_parallel",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Head_helpers_parallel")
comp.run(operation="C_SIMULATION")

vitis.dispose()

