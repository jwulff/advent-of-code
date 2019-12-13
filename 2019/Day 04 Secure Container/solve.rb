#!/usr/bin/env ruby

input = (372037..905157)

def repeating?(x)
  !!x.to_s.match(/(\d)\1{1,1}/)
end

def increasing?(x)
  x == x.to_s.split('').collect(&:to_i).sort.collect(&:to_s).join('').to_i
end

def repeating_but_not_too_much?(x)
  # Remove any sequence of digits repeating more than twice before looking for digits repeating.
  repeating? x.to_s.gsub(/(\d)\1{2,}/, '')
end

possibles = 0
input.each do |candidate|
  next unless repeating?(candidate)
  next unless increasing?(candidate)
  possibles += 1 
end

puts "Found #{possibles} possible passwords for part 1 rules"

possibles = 0
input.each do |candidate|
  next unless repeating_but_not_too_much?(candidate)
  next unless increasing?(candidate)
  possibles += 1 
end

puts "Found #{possibles} possible passwords for part 2 rules"
