#!/usr/bin/env ruby

input = File.read('./INPUT')

class Map
  attr_reader :x, :y, :map

  def initialize(input)
    @map = input.split("\n")
    @map.collect! do |line|
      line = line.split ''
    end
    @width = @map[0].size
    @x = 0
    @y = 0
  end

  def current
    @map[@y][@x]
  end

  def tree?
    current == '#'
  end

  def right!(moves)
    @x += moves
    @x %= @width
  end

  def down!(moves)
    @y += moves
  end

  def end?
    @y < 0 || @y >= @map.size
  end
end

map = Map.new input

trees = 0
loop do
  map.right! 3
  map.down! 1
  if map.end?
    break
  else
    trees += 1 if map.tree?
  end
end

puts trees
