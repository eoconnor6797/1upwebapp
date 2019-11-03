# 1up Health Demo Web Application
Example web application built using 1upHealth FHIR, User &amp; Connect APIs  
This application assumes you have heroku-cli and docker installed.
For information on how to install those tools, instructions can be found here:
[docker installation](https://docs.docker.com/v17.09/engine/installation/)
[heroku-cli installation](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)


## Before you start
Create an application via the 1uphealth devconsole [https://1up.health/devconsole](https://1up.health/devconsole) for dev purposes.  Use `http://localhost:3000/callback` for your app's callback url. Make sure you save your client secret as it'll only be shown once.

Create an application via the heroku console [https://dashboard.heroku.com/new-app](https://dashboard.heroku.com/new-app) for a production environment.

Create a second application via the 1uphealth devconsole [https://1up.health/devconsole](https://1up.health/devconsole) for production. Use `https://<your_heroku_app_name>.herokuapp.com/callback` for you app's callback url. Make sure you save your client secret as it'll only be shown once.

## Quickstart
1. Checkout source code from the repo
```
cd ~/
git clone https://github.com/eoconnor6797/1upwebapp.git
```


2. Add your API keys to app server session, ex. `vim ~/.env-dev` or `~/.env-production`

save you dev credentials in `.env-dev` and production credentials in `.env-production` in the apps working directory.

```
ONEUP_DEMOWEBAPPLOCAL_CLIENTSECRET=<clientsecretclientsecret>
ONEUP_DEMOWEBAPPLOCAL_CLIENTID=<clientidclientid>
```
save this

3. Create `config-dev.json` configuration file with the same dev client_id
```
{
  "baseURL": "http://localhost:3000",
  "clientId": "<dev_client_id>",
  "__clientId": "the client id must be hardcoded here because this will be client side",
  "email": {
    "sender": "address@demo.com"
  }
}
```

4. Create `config-production.json` configuration file with the same production client_id
```
{
  "baseURL": "https://<your_heroku_app_name>.herokuapp.com",
  "clientId": "<production_client_id>",
  "__clientId": "the client id must be hardcoded here because this will be client side",
  "email": {
    "sender": "address@demo.com"
  }
}
```
5. Set up heroku
```
heroku login
heroku container:login
```

6. Running app locally

`python3 deploy.py dev <your_heroku_app_name>`

7. Deploying to heroku

`python3 deploy.py production <your_heroku_app_name>`

Your app will be located at `https://<your_heroku_app_name>.herokuapp.com`

Logs will be located at `https://dashboard.heroku.com/apps/<your_heroku_app_name>/logs`

## Test Health Systems
You can test the demo web app with one of these [FHIR health system accounts](https://1up.health/dev/doc/fhir-test-credentials).

## Optional Setup: Setup email using actual email (relay) server
Either run a test local server for development
```
sudo python -m smtpd -n -c DebuggingServer localhost:25
```
Or setup email js for production in `auth.js`
```
var email 	= require("emailjs");
var server 	= email.server.connect({
   user:    "username",
   password:"password",
   host:    "smtp.your-email.com",
   ssl:     true
});
```

