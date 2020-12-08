#!/usr/bin/env ruby

class Console
  attr_accessor :instructions,
                :position,
                :accumulator,
                :log

  def initialize(input)
    @instructions = input.split("\n").collect do |line|
      pair = line.split
      [ pair[0].to_sym, pair[1].to_i ]
    end
    @position = 0
    @accumulator = 0
    @log = []
    puts self
  end

  def to_s
    "#{position}\t#{operation}\t#{argument}\t#{accumulator}"
  end

  def run!
    while !end?
      log!
      send operation
      puts self
      if log.include?(position)
        puts "BREAK\tPosition #{position} has already been visited."
        break
      end
    end
    puts "END"
  end

  def log!
    self.log << position
  end

  def instruction; instructions[position]; end
  def operation; instruction[0]; end
  def argument; instruction[1]; end
  def end?; position > instructions.size; end

  def acc
    self.accumulator += argument
    self.position += 1
  end

  def jmp
    self.position += argument
  end

  def nop
    self.position += 1
  end
end

input = File.read('./INPUT')

console = Console.new input
console.run!
