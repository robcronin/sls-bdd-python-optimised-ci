from behave import given, when, then, step
import requests
import json


@given('I call the "{endpoint}" endpoint')
def call_endpoint(context, endpoint):
    response = requests.get(f'{context.env.get("domain_name")}{endpoint}')
    context.last_response = response


@then('I see "{message}" in the "{key}" of the response')
def see_string_in_response(context, message, key):
    body = json.loads(context.last_response.text)
    assert body[key] == message


@then('I see {message:d} in the "{key}" of the response')
def see_integer_in_response(context, message, key):
    body = json.loads(context.last_response.text)
    assert body[key] == message


@then("I get a {status:d} response")
def see_status_in_response(context, status):
    print("context", context.last_response.status_code, "\n")
    assert context.last_response.status_code == status
