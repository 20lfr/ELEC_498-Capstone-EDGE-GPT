# 2025-11-24T22:50:29.458711
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_total")

comp = client.create_hls_component(name = "Scheduler_FSM",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Scheduler_FSM")
comp.run(operation="C_SIMULATION")

