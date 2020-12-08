#!/usr/bin/env ruby

class Bag
  def self.for(color)
    @bags ||= {}
    @bags[color] ||= Bag.new(color)
  end

  def self.bags
    @bags
  end

  attr_accessor :color, :parents

  def initialize(color)
    @color = color
    @parents = []
  end

  def to_s
    color
  end

  def ancestors
    (parents + parents.collect{|p| p.ancestors}).flatten.uniq
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
    end
  end
end

puts Bag.for('shiny gold').ancestors.size
