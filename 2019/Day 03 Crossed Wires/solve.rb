#!/usr/bin/env ruby

class Grid
  ORIGIN_MARK = "\e[#{32}mO\e[0m"
  CROSS_MARK = "\e[#{31}mX\e[0m"

  attr_accessor :intersections

  def initialize
    @y_x = [[]]
    @intersections = []
  end

  def mark!(path)
    @y_x[path.y] ||= []
    @y_x[path.y][path.x] ||= []
    @y_x[path.y][path.x] << path
    @intersections << [path.x, path.y] if @y_x[path.y][path.x].size > 1
  end

  def closest_intersection(x = 0, y = 0)
    intersections.sort do |a, b|
      a[0] + a[1] <=> b[0] + b[1]
    end.first
  end

  def render
    o = ''
    @y_x.each_with_index do |line, y|
      if line
        line.each_with_index do |row, x|
          if y == 0 && x == 0
            o << ORIGIN_MARK
          else
            if row
              if row.size == 1
                o << row[0].label
              else
                o << CROSS_MARK
              end
            else
              o << ' '
            end
          end
        end
      else
        o << ''
      end
      o << "\n"
    end
    o
  end
end

class Path
  attr_reader :x, :y, :label

  def initialize(grid, instructions, label)
    @grid = grid
    @x = 0
    @y = 0
    @label = label
    if instructions
      instructions.split(',').each do |instruction|
        direction = instruction[0..0]
        distance = instruction[1..-1].to_i
        move direction, distance
      end
    end
  end

  def move(direction, distance)
    distance.times do
      case direction
      when 'U'
        @y += 1
      when 'D'
        @y -= 1
      when 'R'
        @x += 1
      when 'L'
        @x -= 1
      end
      mark!
    end
  end

  def mark!
    @grid.mark! self
  end
end

grid = Grid.new
Path.new(grid, 'R8,U5,L5,D3', "\e[#{33}mA\e[0m")
Path.new(grid, 'U7,R6,D4,L4', "\e[#{34}mB\e[0m")

puts grid.render

puts "Found intersetions at #{grid.intersections.inspect}"
closest = grid.closest_intersection
puts "Closest intersection to origin at #{closest}, #{closest[0] + closest[1]} from origin."
