from src.response import make_response

def hello(event, context):
    body = {
        "message": "Go Serverless v1.0! Your function executed successfully in python!",
    }

    return make_response(body)
