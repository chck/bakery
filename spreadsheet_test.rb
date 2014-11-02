#!/usr/bin/env ruby
#-*- coding:utf-8 -*-
require 'roo'

book = Roo::Excelx.new("./test.xlsx")
book.default_sheet = book.sheets.first 

puts book.info
