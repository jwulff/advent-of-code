#!/usr/bin/env ruby

input = File.read('./INPUT')
module_masses = input.split.collect &:to_i

def fuel_for(mass)
  mass / 3 - 2
end

required_masses_fuel = 0
required_fuel_fuel = 0

module_masses.each do |mass|
  module_fuel = fuel_for mass
  fuel_fuel = fuel_for module_fuel
  added_fuel = fuel_fuel
  loop do
    added_fuel = fuel_for added_fuel
    if added_fuel >= 0
      fuel_fuel += added_fuel
    else
      break
    end
  end
  required_masses_fuel += module_fuel
  required_fuel_fuel += fuel_fuel
end

puts "Fuel Required for Module Masses: #{required_masses_fuel}"
puts "Fuel Required for Fuel: #{required_fuel_fuel}"
puts "Total Fuel Required: #{required_masses_fuel + required_fuel_fuel}"
