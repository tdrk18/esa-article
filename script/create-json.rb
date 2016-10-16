# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : script/create-json.rb
# Author        : todoroki
# Date Created  : 2016-10-10
#---------------------------------#

require 'json'

def write_json_to_file filename, json
  File.open(filename, 'w') do |file|
    JSON.dump(json, file)
  end
end

def create_hash title, tags, body
  hash = {
  "coediting": false,
  "gist": false,
  "private": false,
  "tweet": true
  }
  hash["title"] = title
  hash["tags"] = []
  tags.split(',').each do |tag|
    hash["tags"].push({"name": tag.strip})
  end
  hash["body"]  = body
  hash
end

def get_new_article
  files = `git log -n 1 --name-status --oneline --all | grep 'html.md'`.split("\n").map{|item| item.split()[-1]}
  files
end

def open_file filename
  title = ""
  tags = ""
  body = ""

  header = 0
  File.open(filename, 'r') do |file|
    file.each_line do |line|
      line = line.strip
      if header < 2
        if line == '---'
          header += 1
          next
        end
        title = line.split(':')[-1].strip.gsub("\"", "") if line.start_with?('title:')
        tags  = line.split(':')[-1].strip if line.start_with?('tags:')
      elsif header < 3
        header += 1
      else
        body += (line + "\n")
      end
    end
  end
  return title, tags, body
end

if __FILE__ == $0

  articles = get_new_article
  title, tags, body = open_file articles[0]

  hash = create_hash title, tags, body
  exit if title == "" or body == ""
  write_json_to_file "script/article.json", hash

end
