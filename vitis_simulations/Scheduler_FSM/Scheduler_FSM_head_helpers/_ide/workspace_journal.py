# 2025-11-28T20:18:31.312602
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_head_helpers")

client.delete_component(name="Head_helpers_parallel")

client.delete_component(name="Head_Helpers_simplified")

client.delete_component(name="Scheduler_FSM_simplified")

comp = client.create_hls_component(name = "Head_Helpers_Parallel",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Head_Helpers_Parallel")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

