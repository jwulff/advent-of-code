#!/usr/bin/env ruby

input = File.read('./INPUT')
module_masses = input.split.collect &:to_i
required_fuel = 0

module_masses.each do |mass|
  required_fuel += mass / 3 - 2
end

puts required_fuel

