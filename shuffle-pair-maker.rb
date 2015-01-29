#!/usr/bin/env ruby
#-*- coding:utf-8 -*-
require 'matrix'

class ShufflePairMaker
  def initialize
    input_member = ARGV
    alphabet = ("A".."Z").to_a
    @group_h = {}
    @member_all = []
    input_member.each_with_index do |file, i|
      member = open(file).readlines.map(&:chomp).uniq
      @group_h[alphabet[i]] = member
      @member_all << member
    end
    @member_all.flatten!.uniq!
    @member_all_log = @member_all
  end

  #ペア作り開始
  def main
    p result = get_pair(@member_all)
    while result[1].size > 1 do
      p result = get_pair(@member_all)
    end
  end

  def get_pair(member_all)
    member_h = get_member_h
    pairs = []
    count_h = {}
    mem_num = member_all.size
    while !member_all.empty? do
      begin
        member_all.shuffle!
        pair = member_all.take(2)
        first = member_h[pair[0]]
        second = member_h[pair[1]]
        if get_similarity(first, second) > 0
          pairs << pair
          member_all = member_all.drop(2)
        end
        p leftovers = "#{member_all.size}/#{mem_num}"
        count_h[leftovers] = count_h[leftovers] ? count_h[leftovers] + 1 : 1
        break if count_h[leftovers] > 100
      rescue
        break
      end
    end
    return pairs, member_all
  end

  def get_member_h
    member_h = {}
    @member_all.each do |member|
      member_v = []
      @group_h.values.each do |group|
        if group.include?(member) 
          member_v << 1
        else
          member_v << 0
        end
      end
      member_h[member] = member_v
    end
    member_h
  end

  def get_similarity(member1, member2)
    vector1 = Vector.elements(member1, copy = true)
    vector2 = Vector.elements(member2, copy = true)
    similarity = vector2.inner_product(vector1)/(vector1.norm * vector2.norm)
    return similarity.round(3)
  end
end

spm = ShufflePairMaker.new
spm.main
