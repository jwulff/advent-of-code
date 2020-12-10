#!/usr/bin/env ruby

class Adapter
  def self.for(joltage)
    @adapters ||= {}
    @sorted = nil # Clear sorted cache
    @adapters[joltage] ||= Adapter.new(joltage)
  end

  def self.sorted
    @sorted ||= @adapters.values.sort{|a,b| a.joltage <=> b.joltage }
  end

  def self.previous(adapter)
    i = sorted.index(adapter) - 1
    i < 0 ? nil : sorted[i]
  end

  def self.next(adapter)
    sorted[sorted.index(adapter) + 1]
  end

  attr_accessor :joltage

  def initialize(joltage)
    self.joltage = joltage
  end

  def to_s
    joltage.to_s
  end

  def previous
    self.class.previous self
  end

  def next
    self.class.next self
  end
end

input = File.read('./INPUT')
input.split("\n").each do |line|
  joltage = line.to_i
  Adapter.for joltage
end

outlet = Adapter.for 0
device = Adapter.for(Adapter.sorted.last.joltage + 3)

one = 0
three = 0
adapter = Adapter.sorted.first
while adapter
  if adapter.previous
    case adapter.joltage - adapter.previous.joltage
    when 1
      one += 1
    when 3
      three += 1
    else
      raise "#{adapter.previous.joltage} - #{adapter.joltage} = #{adapter.joltage - adapter.previous.joltage}"
    end
  end
  adapter = adapter.next
end
puts "1 Joltage increases: #{one}, 3 Joltage increases: #{three}, #{one} * #{three} = #{one * three}"
