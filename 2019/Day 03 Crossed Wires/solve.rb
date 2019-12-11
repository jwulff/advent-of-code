#!/usr/bin/env ruby

class Grid
  ORIGIN_MARK = "\e[#{32}mO\e[0m"
  CROSS_MARK = "\e[#{31}mX\e[0m"

  attr_accessor :intersections

  def initialize
    @y_x = {0 => {0 => []}}
    @intersections = []
  end

  def mark!(path)
    @y_x[path.y] ||= {}
    @y_x[path.y][path.x] ||= []
    @y_x[path.y][path.x] << path
    @intersections << [path.x, path.y] if @y_x[path.y][path.x].size > 1
  end

  def closest_intersection(x = 0, y = 0)
    intersections.sort do |a, b|
      a[0].abs + a[1].abs <=> b[0].abs + b[1].abs
    end.first
  end

  def render
    o = ''
    ys = @y_x.keys.sort
    min_y = ys.first
    max_y = ys.last
    lines = max_y - min_y
    xs = @y_x.values.collect(&:keys).flatten.compact.uniq.sort
    min_x = xs.first
    max_x = xs.last
    rows = max_x - min_x
    line = min_y
    row = min_x

    rows.times do |row|
      y = min_y + row
      lines.times do |line|
        x = min_x + line
        if y == 0 && x == 0
          print ORIGIN_MARK
        else
          cell = @y_x[y][x] rescue nil
          if !cell || cell.size == 0
            print ' '
          elsif cell.size == 1
            print cell.first.label
          else
            print CROSS_MARK
          end
        end 
      end
      print "\n"
    end
  end
end

class Path
  attr_reader :x, :y, :label

  def initialize(grid, instructions, label = 'X')
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

# Run tests
puts "Running tests"
[
  [
    [
      'R8,U5,L5,D3',
      'U7,R6,D4,L4'
    ],
    6
  ],
  [
    [
      'R75,D30,R83,U83,L12,D49,R71,U7,L72',
      'U62,R66,U55,R34,D71,R55,D58,R83'
    ],
    159
  ],
  [
    [
      'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
      'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'
    ],
    135
  ]
].each do |paths, expected_distance|
  grid = Grid.new
  Path.new(grid, paths[0], "\e[#{33}mA\e[0m")
  Path.new(grid, paths[1], "\e[#{34}mB\e[0m")
  closest = grid.closest_intersection
  distance = closest[0].abs + closest[1].abs
  grid.render
  if distance == expected_distance
    puts 'GO'
  else
    puts "NO GO"
    puts "\tClosest intersection to origin found at #{closest}, #{closest[0].abs + closest[1].abs} from origin. Expected to be #{expected_distance} from origin."
  end
end
exit
input = File.read('./INPUT')
path_1, path_2 = input.split

grid = Grid.new
Path.new(grid, path_1, "\e[#{33}mA\e[0m")
Path.new(grid, path_2, "\e[#{34}mB\e[0m")
#grid.render

puts "Found intersetions at #{grid.intersections.inspect}"
closest = grid.closest_intersection
puts "Closest intersection to origin at #{closest}, #{closest[0].abs + closest[1].abs} from origin."
