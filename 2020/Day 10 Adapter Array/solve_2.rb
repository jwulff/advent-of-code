#!/usr/bin/env ruby

class Node
  def self.for_joltage(joltage)
    @@by_joltage[joltage]
  end

  attr_accessor :joltage, :out_1, :out_2, :out_3

  def initialize(joltage)
    self.joltage = joltage
    @@by_joltage ||= {}
    @@by_joltage[joltage] = self
  end

  def to_s
    "#{joltage}\t1:#{out_1 && out_1.joltage}\t3:#{out_2 && out_2.joltage}\t3:#{out_3 && out_3.joltage}"
  end

  def <=>(other)
    joltage <=> other.joltage
  end

  def paths
    unless @paths
      if !out_1 && !out_2 && !out_3
        @paths = 1
      else
        @paths = (out_1 ? out_1.paths : 0) + 
                 (out_2 ? out_2.paths : 0) + 
                 (out_3 ? out_3.paths : 0)
      end
    end
    @paths
  end
end

input = File.read('./INPUT')
nodes = input.split("\n").collect do |line|
  Node.new line.to_i
end
nodes << (outlet = Node.new(0)) # Outlet
nodes.sort!
nodes << Node.new(nodes.last.joltage + 3) # Device

nodes.each do |node|
  node.out_1 = Node.for_joltage(node.joltage + 1)
  node.out_2 = Node.for_joltage(node.joltage + 2)
  node.out_3 = Node.for_joltage(node.joltage + 3)
  puts node
end

puts outlet.paths
