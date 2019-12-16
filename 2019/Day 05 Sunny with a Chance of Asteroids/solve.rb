#!/usr/bin/env ruby

class IntcodeComputer
  attr_accessor :codes, :i

  def initialize(codes)
    self.codes = codes
    self.i = 0
  end

  def run!
    loop do
      case opcode
      when  1; add;
      when  2; multiply;
      when  3; input;
      when  4; output;
      when 99; break;
      else
        puts "Unknown opscode #{opcode} in position #{i}. Halting."
        break
      end
    end
  end

  def opcode
    codes[i] % 100
  end

  def add
    codes[codes[i + 3]] = codes[codes[i + 1]] + codes[codes[i + 2]]
    self.i += 4
  end

  def multiply
    codes[codes[i + 3]] = codes[codes[i + 1]] * codes[codes[i + 2]] 
    self.i += 4
  end

  def input
    print "Input: "
    input = gets.strip.to_i
    codes[codes[i + 1]] = input
    self.i += 2
  end

  def output
    puts "Output: #{codes[codes[i + 1]]}"
    self.i += 2
  end
end

# Run tests
puts "Running Self Diagnostic"
[
  [[1,0,0,0,99], [2,0,0,0,99]], # Example from Day 2
  [[2,3,0,3,99], [2,3,0,6,99]], # Example from Day 2
  [[2,4,4,5,99,0], [2,4,4,5,99,9801]], # Example from Day 2
  [[1,1,1,4,99,5,6,0,99], [30,1,1,4,2,5,6,0,99]], # Example from Day 2
  [[3,0,4,0,99], [5,0,4,0,99]] # Example for input/output, assumes input of 5
].each do |test|
  ic = IntcodeComputer.new test[0]
  ic.run!
  result = ic.codes
  if result == test[1]
    puts "GO"
  else
    puts "NO GO\n\tINPUT:\t#{test[0]}\n\tEXPECT:\t#{test[1]}\n\tACTUAL:\t#{result}"
  end
end
