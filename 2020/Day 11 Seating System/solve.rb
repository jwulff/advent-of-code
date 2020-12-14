#!/usr/bin/env ruby

class Plane
  def initialize(input)
    row = 0
    @map = input.split("\n").collect do |line|
      col = 0
      x = line.split('').collect do |value|
        seat = Seat.new self, row, col, value
        col += 1
        seat
      end
      row += 1
      x
    end
  end

  def to_s
    @map.collect(&:join).join("\n")
  end

  def seat(row, col)
    return nil if row < 0 || col < 0
    @map[row] && @map[row][col]
  end

  def seats
    @map.flatten
  end

  def run!
    changes = []
    seats.each do |x|
      next if x.floor?
      n = x.occupied_neighbors.size
      if x.empty? && n == 0
        changes << ->{ x.occupy! }
      elsif x.occupied? && n >= 4
        changes << ->{ x.empty! }
      end
    end
    changes.each &:call
    changes.size
  end

  def run2!
    changes = []
    seats.each do |x|
      next if x.floor?
      n = x.visibly_occupied_neighbors.size
      if x.empty? && n == 0
        changes << ->{ x.occupy! }
      elsif x.occupied? && n >= 5
        changes << ->{ x.empty! }
      end
    end
    changes.each &:call
    changes.size
  end
end

class Seat
  attr_accessor :plane, :row, :col, :value

  def initialize(plane, row, col, value)
    @plane = plane
    @row = row
    @col = col
    @value = value
  end

  def to_s
    value
  end

  def floor?; @value == '.'; end
  def empty?; @value == 'L'; end
  def occupied?; @value == '#'; end
  def occupy!; @value = '#'; end
  def empty!; @value = 'L'; end

  def occupied_neighbors
    neighbors.find_all &:occupied?
  end

  def neighbors
    @neighbors ||= [ 
      plane.seat(row - 1, col - 1),
      plane.seat(row - 1, col    ),
      plane.seat(row - 1, col + 1),
      plane.seat(row    , col - 1),
      # Self
      plane.seat(row    , col + 1),
      plane.seat(row + 1, col - 1),
      plane.seat(row + 1, col    ),
      plane.seat(row + 1, col + 1)
    ].compact
  end

  def visibly_occupied_neighbor(rd, cd)
    s = plane.seat row + rd, col + cd
    if s
      if s.occupied?
        s
      elsif s.empty?
        nil
      else
        s.visibly_occupied_neighbor(rd, cd)
      end
    end
  end

  def visibly_occupied_neighbors
    [
      visibly_occupied_neighbor(-1, -1),
      visibly_occupied_neighbor(-1,  0),
      visibly_occupied_neighbor(-1,  1),
      visibly_occupied_neighbor( 0, -1),
      #self
      visibly_occupied_neighbor( 0,  1),
      visibly_occupied_neighbor( 1, -1),
      visibly_occupied_neighbor( 1,  0),
      visibly_occupied_neighbor( 1,  1)
    ].compact
  end
end

input = File.read('./INPUT')

# Part 1
plane = Plane.new input
loop do
  changes = plane.run!
  break if changes == 0
end
puts plane.seats.find_all(&:occupied?).size

# Part 2
plane = Plane.new input
loop do
  changes = plane.run2!
  break if changes == 0
end
puts plane.seats.find_all(&:occupied?).size
