import json

def sum(event, context):
    body = json.loads(event["body"])
    response_body = {
        "message": "Your inputs have been summed",
        "result": body["a"] + body["b"]
    }

    response = {
        "statusCode": 200,
        "body": json.dumps(response_body)
    }

    return response

