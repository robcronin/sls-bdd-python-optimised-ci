# sls-bdd-python-optimised-ci

A Serverless BDD Example in Python using an Optimised CI Pipeline

This is an example repo using the lock table as laid out in the [bdd-lock-table repo](https://github.com/robcronin/bdd-lock-table)
- Check that out first for more context

It runs a number of [behave](https://github.com/behave/behave) BDD tests on some simple python serverless functions


## Running Locally

Requires:

- python 3.7
- yarn (assumed) *or* `sls` installed globally
- An AWS profile with access keys

### Installation

- `yarn`
- `pipenv install --dev`

###  <a id="deploy"></a>Deploy

*Note* if you are not using your default AWS profile then add `--aws-profile {YOUR_PROFILE}` to the end of these commands

- Full deploy: `yarn deploy --stackName {YOUR_STACK_NAME}`
- Function deploy: `yarn deploy -f {FUNCTION NAME} --stackName {YOUR_STACK_NAME}`

### Behave Tests

Behave tests are intended to run against an existing stack so these steps assume you have [deployed](#deploy) a version of the code

- Create your environment file: `cp features/environment-dist.py features/environment.py`
    - Update features/environment.py with your domain name e.g. `https://xxxxxxxxxx.execute-api.eu-west-2.amazonaws.com/dev`
- Run: `yarn test:behave`
- For debugging with print statements you need to add a newline for all prints to avoid it being overwritten by behave (i.e. `print('Message here\n')`)

## Running on CI

Requires:

- A BDD lock table from lock table [bdd-lock-table repo](https://github.com/robcronin/bdd-lock-table) setup
- A [CircleCI](https://circleci.com/) account (other CI Platforms should work if you tweak the [config](./.circleci/config.yml) appropriately)


It will run 2 builds:

- `build-with-no-lock`: will create a brand new stack, run the BDD tests and then teardown the stack
- `build-with-lock`: (based on [bdd-lock-table repo](https://github.com/robcronin/bdd-lock-table)) will attempt to claim an existing stack or else make a new one, run the BDD tests and then release the stack back into circulation

If a stack is availble this typically brings the build time from 2:40 to 1:10

### Setup

- Configure your CI and add the following environment variables to your CI:
    - `BDD_LOCK_ENDPOINT`: The root of your deployed **bdd-lock-table** endpoints e.g. `https://xxxxxxxxxx.execute-api.eu-west-2.amazonaws.com/dev`
    - `BDD_LOCK_AUTH_TOKEN`: The password you generated and stored in ssm when setting up your **bdd-lock-table**
    - `REPO_NAME`: your repo name e.g. `sls-bdd-python-optimised-ci`
