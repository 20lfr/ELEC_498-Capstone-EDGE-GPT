# 2025-11-25T13:16:21.576726
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_head_helpers")

comp = client.create_hls_component(name = "Head_helpers_simplified",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Head_helpers_simplified")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp = client.create_hls_component(name = "Scheduler_FSM_simplified",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Scheduler_FSM_simplified")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

