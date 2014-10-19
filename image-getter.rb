#!/usr/bin/ruby
# -*- coding: utf-8 -*-
#クエリの画像を1枚生成するだけ
#検索くえり詳細
#	afgt.net/blog/archives/18202

require 'cgi'
require 'open-uri'
require 'json'
require 'csv'
require 'rainbow'

class ImageGetter
  def initialize
    @start = 0
    @count = 0
    $dpath = "."	#ほぞんばしょ
    system("mkdir #{$dpath}/image") unless File.exist?("#{$dpath}/image")
  end

  def main(word)
    @search_word = CGI::escape(word)
    while @start <= 64
      page = open("http://ajax.googleapis.com/ajax/services/search/images?q=#{@search_word}&v=1.0&hl=ja&rsz=large&start=#{@start}&safe=off&imgc=color&imgtype=face")
      page.each_line do |line|
        exit if JSON[line]['responseStatus'] != 200
        search_result = JSON[line]['responseData']
        urls = []
        search_result['results'].each do |h|
          urls << h.values_at('url')
        end
        urls.flatten!
        urls.size.times do |i|
          begin
            open(urls[i]) do |image_f|
              #File.open("#{$dpath}/image/#{word}_#{@count}.jpg","w") do |f|
              File.open("#{$dpath}/image/baachan_#{@count}.jpg","w") do |f|

                puts Rainbow("downloading ... #{word.chomp}_#{@count}.jpg").red.inverse.hide
                data = image_f.read
                f.write data
                #puts "	done"
              end
            end
          rescue
            p $!
            next
          end
          @count += 1
        end
      end
      @start += 8
    end
  end
end

ig = ImageGetter.new
#ig.readList
ig.main("おばあちゃん")
