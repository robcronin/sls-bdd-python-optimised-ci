import sys
import json
import random

resp = sys.stdin.read()
body = json.loads(resp)

num_stacks = len(body["results"])
if(num_stacks == 0):
    print("NO STACKS")
else:
    print(body["results"][0]["stackName"])