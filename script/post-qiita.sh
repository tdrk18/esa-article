#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : script/post-qiita.sh
# Author        : todoroki
# Date Created  : 2016-10-10
#---------------------------------#

# 記事用の古いjsonがあれば削除
if [ -e script/article.json ]; then
    rm script/article.json
fi

# 記事用のjsonを作成
ruby script/create-json.rb

# もしarticle.jsonがなければ何もしない
if [ ! -e script/article.json ]; then
    exit
fi

# jsonデータから記事ををqiitaにpost
curl -X POST http://qiita.com/api/v2/items \
     -H "Authorization: Bearer $QIITA_TOKEN" \
     -H 'Content-Type: application/json' \
     -d @script/article.json

