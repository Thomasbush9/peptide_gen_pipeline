from pathlib import Path 
import json 
import yaml


def load_yaml(yaml_path:str):

    with open(yaml_path, 'r') as stream:
        data = yaml.safe_load(stream)
    return data


def parse_yaml_bg(yaml_path:str):
    pass
def convert_yaml_to_json(yaml_path:str):
    """Function to convert yaml config file for BoltzGen to json config file for Bindcraft"""
    BC_STRUCTURE= {
    "design_path": "/content/drive/My Drive/BindCraft/PDL1/",
    "binder_name": "PDL1",
    "starting_pdb": "/content/bindcraft/example/PDL1.pdb",
    "chains": "A",
    "target_hotspot_residues": "56",
    "lengths": [65, 150],
    "number_of_final_designs": 100
    }




if __name__ == "__main__":

    yaml_path = "/Users/thomasbush/Downloads/gfp_design.yaml"
    data = load_yaml(yaml_path)
    print(data["entities"][0])
    print(data["entities"][1])
