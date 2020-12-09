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

  def contiguous_addends_for(number)
    data.each_with_index do |n, i|
      next if n >= number
      sum = n
      y = i + 1
      while sum < number
        sum += data[y]
        if sum == number
          return data[i..y]
        else
          y += 1
        end
      end
    end
  end

  def next_invalid
    while !end?
      if !valid?
        return value
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
invalid = xmas.next_invalid
puts invalid
addends = xmas.contiguous_addends_for(invalid)
addends.sort!
puts addends.first + addends.last

