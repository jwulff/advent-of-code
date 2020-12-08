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
    reset!
    puts self
  end

  def reset!
    @position = 0
    @accumulator = 0
    @log = []
  end

  def to_s
    "#{position}\t#{operation}\t#{argument}\t#{accumulator}"
  end

  def run!
    while !end?
      log!
      send operation
      if log.include?(position)
        break
        return false
      end
    end
    true
  end

  def swap_nop_or_jmp!(pos)
    case instructions[pos][0]
    when :jmp
      instructions[pos][0] = :nop
    when :nop
      instructions[pos][0] = :jmp
    end
  end

  def next_nop_or_jmp(pos = -1)
    instructions.each_with_index do |i, n|
      return n if n > pos && (i[0] == :nop || i[0] == :jmp)
    end
  end

  def debug!
    try_i = next_nop_or_jmp
    loop do
      swap_nop_or_jmp! try_i
      reset!
      run!
      swap_nop_or_jmp! try_i
      if end?
        puts "SUCCESS\tSwapped #{try_i}"
        puts accumulator
        break
      else
        puts "FAILURE\tSwapped #{try_i}"
        try_i = next_nop_or_jmp(try_i)
      end
    end
  end

  def log!
    self.log << position
  end

  def instruction; instructions[position]; end
  def operation; instruction[0]; end
  def argument; instruction[1]; end
  def end?; position == instructions.size; end

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
console.debug!
