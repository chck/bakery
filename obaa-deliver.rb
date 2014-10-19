#!/usr/bin/ruby
# -*- coding: utf-8 -*-
#おばあちゃんデリバリーサービス

obaa_rand = "baachan_#{rand(61)}.jpg"
IMAGE_PATH = "#{File.expand_path(File.dirname(__FILE__))}/image/#{obaa_rand}"
system("scp #{IMAGE_PATH} user@xx.xxx.xx.xx:./m9")
