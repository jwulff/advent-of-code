#!/usr/bin/env ruby

input = File.read('./INPUT')

class Map
  attr_reader :x, :y, :map, :hits

  def initialize(input)
    @map = input.split("\n")
    @map.collect! do |line|
      line = line.split ''
    end
    @width = @map[0].size
    restart!
  end

  def restart!
    @x = 0
    @y = 0
    @hits = 0
  end

  def current
    map[@y][@x] if @map[@y]
  end

  def tree?
    current == '#'
  end

  def move!(x, y)
    right! x
    down! y
    @hits += 1 if tree?
  end

  def right!(moves)
    @x += moves
    @x %= @width
  end

  def down!(moves)
    @y += moves
  end

  def end?
    !current
  end

  def run!(x, y)
    restart!
    loop do
      move! x, y
      break if end?
    end
  end
end

map = Map.new input
map.run! 3, 1
puts map.hits

# Part 2

slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]

hits = slopes.collect do |x, y|
  map.run! x, y
  puts "#{x}, #{y} hits #{map.hits} trees"
  map.hits
end

puts hits.inject(:*)
