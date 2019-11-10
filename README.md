# sls-bdd
Serverless BDD setups


## Python

### Installation

- `yarn`
- `pipenv install --dev`

### Deploy

- Full deploy: `yarn deploy` or `yarn deploy --aws-profile {YOUR_PROFILE}`
- Function deploy: `yarn deploy -f {FUNCTION NAME}` or `yarn deploy -f {FUNCTION NAME} --aws-profile {YOUR_PROFILE}`

### Behave Tests

- Create your environment file: `cp features/environment-dist.py features/environment.py`
    - Update any relevant variables in here
- Run: `yarn test:behave`
- For debugging with print statements you need to add a newline for all prints to avoid it being overwritten by behave (i.e. `print('Message here\n')`)