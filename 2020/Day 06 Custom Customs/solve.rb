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

  def group_yesses
    people.first.yesses.find_all do |yes|
      all = true
      people[1..-1].each do |other|
        all = false unless other.yesses.include?(yes)
      end
      all
    end
  end
end

input = File.read('./INPUT')

groups = input.split("\n\n").collect do |input|
  Group.new input
end

puts groups.collect(&:yesses).flatten.size
puts groups.collect(&:group_yesses).flatten.size
