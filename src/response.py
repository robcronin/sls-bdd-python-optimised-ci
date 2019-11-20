import json


def make_response(message, status=200):
    return {"body": json.dumps(message), "statusCode": status}
