#!/usr/bin/env ruby

class XMAS
  PREAMBLE_SIZE = 25

  attr_accessor :data, :position

  def initialize(input)
    @data = input.split("\n").collect do |line|
      line.to_i
    end
    @position = PREAMBLE_SIZE
  end

  def run!
    while !end?
      if !valid?
        puts "Position: #{position}\tValue: #{value} is not valid."
      end
      next!
    end
  end

  def next!
    @position += 1
  end

  def end?
    position == data.size
  end

  def valid?
    trail.each do |x|
      trail.each do |y|
        return true if x + y == value
      end
    end
    false
  end

  def trail
    data[(position - PREAMBLE_SIZE)..(position - 1)]
  end

  def value
    data[position]
  end
end

input = File.read('./INPUT')

xmas = XMAS.new input
puts xmas.run!
