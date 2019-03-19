#!/bin/bash

docker run \
  -e GIT_REPO=git@github.com:INSERT_REPO_NAME.git \
  -e GIT_DEPLOY_KEY_BASE64='SEE_README' \
  -e NGINX_HTPASSWD_BASE64='SEE_README' \
  koen92/docker-git-webserver:latest
