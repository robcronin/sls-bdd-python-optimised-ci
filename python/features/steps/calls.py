from behave import given, when, then, step
import requests
import json

@given('I call the "{endpoint}" endpoint')
def call_endpoint(context, endpoint):
    response = requests.get(f'{context.env.get("domain_name")}{endpoint}')
    context.last_response = response

@then('I see "{message}" in the "{key}" of the response')
def step_impl(context, message, key):
    body = json.loads(context.last_response.text)
    assert body[key] == message
