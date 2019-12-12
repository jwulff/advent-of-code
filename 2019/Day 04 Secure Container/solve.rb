#!/usr/bin/env ruby

input = (372037..905157)

possibles = 0

def repeating?(x)
  x = x.to_s
  x.include?('00') ||
  x.include?('11') ||
  x.include?('22') ||
  x.include?('33') ||
  x.include?('44') ||
  x.include?('55') ||
  x.include?('66') ||
  x.include?('77') ||
  x.include?('88') ||
  x.include?('99')
end

def increasing?(x)
  x == x.to_s.split('').collect(&:to_i).sort.collect(&:to_s).join('').to_i
end

input.each do |candidate|
  next unless repeating?(candidate)
  next unless increasing?(candidate)
  possibles += 1 
end

puts "Found #{possibles} possible passwords"
