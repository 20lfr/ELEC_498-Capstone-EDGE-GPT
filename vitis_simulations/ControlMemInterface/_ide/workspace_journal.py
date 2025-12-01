# 2025-12-01T16:37:09.333810
import vitis

client = vitis.create_client()
client.set_workspace(path="ControlMemInterface")

comp = client.create_hls_component(name = "ControlMemInterface",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="ControlMemInterface")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

