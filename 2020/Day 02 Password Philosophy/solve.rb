#!/usr/bin/env ruby

input = File.read('./INPUT')
input = input.split("\n")

def valid?(min, max, letter, sample)
  found = sample.split('').find_all{|x| x == letter}.size
  found >= min && found <= max
end

valid = 0
policies = input.each do |line|
  count, letter, sample = *line.split
  min, max = *count.split('-')
  min = min.to_i
  max = max.to_i
  letter = letter[0]
  valid += 1 if valid?(min, max, letter, sample)
end

puts valid
