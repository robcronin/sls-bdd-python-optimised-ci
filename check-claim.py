import sys
import json
import random

resp = sys.stdin.read()
body = json.loads(resp)

if(body["info"] == "Successfully claimed stack"):
    print("OK")
else:
    print("KO")