#!/usr/bin/env ruby

class Person
  attr_reader :yesses
  
  def initialize(input)
    @yesses = input.split('')
  end
end

class Group
  attr_reader :people
  
  def initialize(lines)
    @people = lines.split("\n").collect do |line|
      Person.new line
    end
  end
  
  def yesses
    people.collect(&:yesses).flatten.uniq
  end
end

input = File.read('./INPUT')

groups = input.split("\n\n").collect do |input|
  Group.new input
end

puts groups.collect(&:yesses).flatten.size
