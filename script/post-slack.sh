#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : script/post-slack.sh
# Author        : todoroki
# Date Created  : 2017-04-12
#---------------------------------#

curl -X POST -H 'Content-type: application/json' \
  --data '{"text":"posted to Qiita"}' \
  $SLACK_WEBHOOK_URL

