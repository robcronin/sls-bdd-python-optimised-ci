import json
from src.response import make_response


def sum(event, context):
    body = json.loads(event["body"])
    a = body["a"]
    b = body["b"]

    if not isinstance(a, int) or not isinstance(b, int):
        return make_response({"error": "Must pass integers"}, 400)

    response_body = {"message": "Your inputs have been summed", "result": a + b}

    return make_response(response_body)
