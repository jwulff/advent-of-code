#!/usr/bin/env ruby

examples = [
  [['R8,U5,L5,D3', 'U7,R6,D4,L4'], 6],
  [['R75,D30,R83,U83,L12,D49,R71,U7,L72', 'U62,R66,U55,R34,D71,R55,D58,R83'], 159],
  [['R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51', 'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'], 135]
]

class Wire
  attr_accessor :input, :path, :tip

  def initialize(input)
    self.input = input
    self.path = []
    self.tip = [0,0]
    route!
  end

  def route!
    input.split(',').each do |move|
      direction = move[0..0]
      distance = move[1..-1].to_i
      distance.times do
        case direction
        when 'R'; right!
        when 'L'; left!
        when 'U'; up!
        when 'D'; down!
        end
      end
    end
  end

  def record!
    self.path << tip.dup
  end

  def right!; self.record!;self.tip[0] += 1; end
  def left!;  self.record!;self.tip[0] -= 1; end
  def up!;    self.record!;self.tip[1] += 1; end
  def down!;  self.record!;self.tip[1] -= 1; end
end

class Panel
  attr_accessor :wires

  def initialize
    self.wires = []
  end

  def intersections
    wires.collect(&:path).inject &:&
  end

  def distance_to_origin(point)
    point[0].abs + point[1].abs
  end

  def closest_intersection_to_origin
    intersections.sort do |a, b|
      distance_to_origin(a) <=> distance_to_origin(b)
    end[1]
  end

  def closest_intersection_distance_to_origin
    distance_to_origin closest_intersection_to_origin
  end
end

examples.each do |paths, closest_intersection_distance|
  panel = Panel.new
  paths.each do |path|
    panel.wires << Wire.new(path)
  end

  puts "Expect #{paths.inspect} to have closest intersection distance of #{closest_intersection_distance}"
  puts "\tpanel.closest_intersection_distance_to_origin returns: #{panel.closest_intersection_distance_to_origin}"
end

input = File.read('./INPUT')
path_1, path_2 = input.split

panel = Panel.new
panel.wires << Wire.new(path_1)
panel.wires << Wire.new(path_2)

puts "Finding lowest distance to origin of intersection of wires in INPUT."
puts "#{panel.closest_intersection_distance_to_origin}"
