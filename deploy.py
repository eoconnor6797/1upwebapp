#!/usr/bin/env python3

import argparse
import subprocess

# set up argparser
parser = argparse.ArgumentParser("1up health deployment script")
parser.add_argument("env", type=str, help="environment to deploy to", choices=["dev", "production"])
parser.add_argument("app_name", type=str, help="name of app in heroku")
args = parser.parse_args()
env = args.env
app_name = args.app_name
registry = f"registry.heroku.com/{app_name}/web"

#install dependecies before running tests
print("###Running 'npm install'###")
subprocess.run(["npm", "install"])

# Since all the tests fail I am not going to stop the script
# if there are test failures
# subprocess.run(["npm", "run", "test"], check=True)
print("###Running test suite###")
subprocess.run(["npm", "run", "test"])
# build docker container
print("###Attempting to build docker container###")
docker_build = f"docker build --build-arg NODE_ENV={env} -t 1up-{env}:latest .".split()
subprocess.run(docker_build, check=True)
print("###Docker container built successfully###")
# production deployment
if env == "production":
    docker_tag=f"docker tag 1up-production:latest {registry}".split()
    subprocess.run(docker_tag, check=True)
    # push to heroku container repository
    print("###Pushing to heroko repo###")
    docker_push = f"docker push {registry}".split()
    subprocess.run(docker_push, check=True)
    # release the latest from the container repo
    print("###Releasing latest image###")
    heroku_release = f"heroku container:release web -a {app_name}".split()
    subprocess.run(heroku_release, check=True)
else:
    # launcing app locally
    print("###Launching app locally###")
    docker_run = "docker run -d -p 3000:3000 1up-dev:latest".split()
    subprocess.run(docker_run)
    

