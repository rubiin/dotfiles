import json


def read_config():
    with open('config.json', 'r') as file:
        # Load JSON data into a Python dictionary
        data = json.load(file)
    return data
