require "colorize"

class Tile
  attr_accessor :value, :given

  def initialize(value)
    @value = value
    @given = (value != 0)
  end

  def change_value(new_value)
    if @given
      puts "Sorry dog, can't do that"
    elsif (1..9).include?(new_value)
      @value = new_value
    end
  end

  def to_s
    return " " if @value == 0
    return @value.to_s.colorize(:red) if @given
    return @value.to_s.colorize(:blue) unless @given
  end

end
