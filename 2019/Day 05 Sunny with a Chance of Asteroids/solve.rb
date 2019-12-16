#!/usr/bin/env ruby

def run(codes)
  i = 0
  loop do
    case codes[i]
    when 1 # Addition
      codes[codes[i + 3]] = codes[codes[i + 1]] + codes[codes[i + 2]]
      i += 4
    when 2 # Multiplication
      codes[codes[i + 3]] = codes[codes[i + 1]] * codes[codes[i + 2]]
      i += 4
    when 3 # Input
      print "Input: "
      input = gets.strip.to_i
      codes[codes[i + 1]] = input
      i += 2
    when 4 # Output
      puts "Output: #{codes[codes[i + 1]]}"
      i += 2
    when 99 # Halt
      break
    else
      puts "Unknown opscode #{codes[i]} in position #{i}. Halting."
      break
    end
  end
  codes
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
  result = run test[0]
  if result == test[1]
    puts "GO"
  else
    puts "NO GO\n\tINPUT:\t#{test[0]}\n\tEXPECT:\t#{test[1]}\n\tACTUAL:\t#{result}"
  end
end
