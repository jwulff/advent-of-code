#!/usr/bin/env ruby

input = File.read('./INPUT')
input = input.split
input.collect! &:to_i

found = false
input.each do |x|
  input.each do |y|
    if x + y == 2020
      puts x * y
      found = true
    end
    break if found
  end
  break if found
end
