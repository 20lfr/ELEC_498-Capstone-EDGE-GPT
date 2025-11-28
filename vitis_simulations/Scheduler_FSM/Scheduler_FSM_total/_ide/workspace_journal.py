# 2025-11-27T18:40:36.637636
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_total")

comp = client.create_hls_component(name = "Scheduler_FSM_Multi_Head",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Scheduler_FSM_Multi_Head")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

