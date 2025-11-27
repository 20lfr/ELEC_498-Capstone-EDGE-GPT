# 2025-11-26T20:21:52.628495
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_head_helpers")

comp = client.get_component(name="Head_helpers_parallel")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

vitis.dispose()

