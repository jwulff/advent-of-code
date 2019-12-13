#!/usr/bin/env ruby

input = (372037..905157)

possibles = 0

def repeating?(x)
  !!x.to_s.match(/(\d)\1{1,1}/)
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
