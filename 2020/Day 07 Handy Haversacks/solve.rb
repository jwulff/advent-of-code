#!/usr/bin/env ruby

class Bag
  def self.for(color)
    @bags ||= {}
    @bags[color] ||= Bag.new(color)
  end

  def self.bags
    @bags
  end

  attr_accessor :color, :parents, :children

  def initialize(color)
    @color = color
    @parents = []
    @children = {}
  end

  def to_s
    color
  end

  def ancestors
    (parents + parents.collect(&:ancestors)).flatten.uniq
  end

  def descendant_count
    total = 0
    children.each_pair do |child, count|
      total += count
      total += count * child.descendant_count
    end
    total
  end
end

input = File.read('./INPUT')

rules = input.split("\n").collect do |input|
  _, color, contains = *input.match(/\A(.+)\ bags contain\ (.+)\z/)
  parent = Bag.for color
  if contains != 'contain no other bags'
    contains.split(', ').each do |x|
      _, count, color = *x.match(/(\d+)\ (.+)\ bag/)
      child = Bag.for color
      child.parents << parent
      parent.children[child] = count.to_i
    end
  end
end

puts Bag.for('shiny gold').ancestors.size
puts Bag.for('shiny gold').descendant_count
