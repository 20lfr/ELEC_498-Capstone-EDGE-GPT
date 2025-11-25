# 2025-11-24T22:52:40.819046
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_head_helpers")

comp = client.create_hls_component(name = "Head_Helpers",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Head_Helpers")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

