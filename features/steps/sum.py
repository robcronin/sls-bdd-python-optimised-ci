from behave import given, when, then, step
import requests
import json


@given('I send {a:d} and {b:d} to the "/sum" endpoint')
def call_sum(context, a, b):
    response = requests.post(
        f'{context.env.get("domain_name")}/sum', data=json.dumps({"a": a, "b": b}),
    )
    context.last_response = response


@given('I send "{a}" and "{b}" to the "/sum" endpoint')
def call_sum_with_strings(context, a, b):
    response = requests.post(
        f'{context.env.get("domain_name")}/sum', data=json.dumps({"a": a, "b": b}),
    )
    context.last_response = response
