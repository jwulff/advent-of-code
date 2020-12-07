#!/usr/bin/env ruby

input = File.read('./INPUT')
input = input.split("\n")

# Part 1

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

# Part 2

def valid?(a, b, letter, sample)
  ax = sample[a-1]
  bx = sample[b-1]
  (ax == letter || bx == letter) && !(ax == letter && bx == letter)
end

# Tests
#  1-3 a: abcde is valid: position 1 contains a and position 3 does not.
#  1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
#  2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.
raise unless valid?(1, 3, 'a', 'abcde')
raise unless !valid?(1, 3, 'b', 'cdefg')
raise unless !valid?(2, 9, 'c', 'ccccccccc')

valid = 0
policies = input.each_with_index do |line, i|
  positions, letter, sample = *line.split
  a, b = *positions.split('-')
  a = a.to_i
  b = b.to_i
  letter = letter[0]
  raise "Input #{i}: `#{line}` split to `#{positions}`, `#{letter}`, `#{sample}`" unless letter.size == 1
  valid += 1 if valid?(a, b, letter, sample)
end

puts valid
