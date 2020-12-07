#!/usr/bin/env ruby

class Seat
  VALID = /[FB]{7}[LR]{3}/
  
  attr_reader :input

  def initialize(input)
    @input = input
    raise "Invalid input `#{input}`" unless input.match(VALID)
  end

  def row
    row = input[0..6]
    row.gsub! 'F', '0'
    row.gsub! 'B', '1'
    row.to_i 2
  end
  
  def col
    col = input[7..9]
    col.gsub! 'L', '0'
    col.gsub! 'R', '1'
    col.to_i 2
  end

  def id
    row * 8 + col
  end

  def to_s
    "#{input}, row: #{row}, col: #{col}, id: #{id}"
  end
end

test_seat = Seat.new('FBFBBFFRLR')
raise unless test_seat.row == 44
raise unless test_seat.col == 5
raise unless test_seat.id == 357

input = File.read('./INPUT')
seats = input.split("\n").collect do |line|
  Seat.new line
end

seats.sort! do |a, b|
  a.id <=> b.id
end

puts seats.last.id

x = seats.first.id - 1
seats.each do |seat|
  if seat.id - 1 == x
    x = seat.id
  else
    puts x + 1
    break
  end
end
