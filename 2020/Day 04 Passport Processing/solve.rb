#!/usr/bin/env ruby

class Passport 
  KEYS = [
    :byr, # Birth Year
    :iyr, # Issue Year
    :eyr, # Expiration Year
    :hgt, # Height
    :hcl, # Hair Color
    :ecl, # Eye Color
    :pid, # Passport ID
    :cid  # Country ID
  ]
  REQUIRED_KEYS = KEYS - [ :cid ]
  
  KEYS.each { |key| attr_accessor key }

  def to_s
    KEYS.collect do |k|
      base = "#{k}:#{send k}"
      if send("valid_#{k}?")
        base
      else
        "\u001b[31m#{base}\u001b[0m"
      end
    end.join(', ')
  end

  def valid?
    REQUIRED_KEYS.each do |key|
      return false unless send("valid_#{key}?")
    end
  end

  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  def valid_byr?; byr.to_i >= 1920 && byr.to_i <= 2002; end
  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  def valid_iyr?; iyr.to_i >= 2010 && iyr.to_i <= 2020; end
  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  def valid_eyr?; eyr.to_i >= 2020 && eyr.to_i <= 2030; end
  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.
  def valid_hgt?
    if hgt && (height = hgt.match(/\A(\d+)(cm|in)\z/))
      x = height[1].to_i
      case height[2]
      when 'cm'
        x >= 150 && x <= 193
      when 'in'
        x >= 59 && x <= 76
      end
    else
      false
    end
  end
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  def valid_hcl?; hcl && hcl.match(/\A#[abcdef0-9]{6}\z/); end
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  def valid_ecl?; ecl && %w{amb blu brn gry grn hzl oth}.include?(ecl); end
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  def valid_pid?; pid && pid.match(/\A\d{9}\z/) end
  # cid (Country ID) - ignored, missing or not.
  def valid_cid?; true; end
end

input = File.read('./INPUT')
passports = input.split("\n\n").collect do |lines|
  passport = Passport.new
  lines.split.each do |token|
    key, value = *token.split(':')
    passport.send("#{key}=", value)
  end
  passport
end

valid = 0

passports.each do |passport|
  if passport.valid?
    valid += 1
  else
    puts passport
  end
end

puts valid