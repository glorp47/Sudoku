require_relative "tile"

class Board
  attr_accessor :grid

  def initialize(grid = Array.new(9) {Array.new(9)})
    @grid = grid
  end

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    grid = []
    rows.each_with_index do |row, index|
      grid[index] = row.chars.map(&:to_i)
    end
      grid.each do |row|
        row.map! {|value| Tile.new(value)}
    end
    self.new(grid)
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]].change_value(value)
  end

  def render
    puts "GRID"
    0.upto(@grid.length-1) do |i|
      print "  " if i == 0
      print "|#{i}|"
    end
    puts ""
    @grid.each_with_index do |row, idx|
      row.each_with_index do |tile, idx2|
        print "#{idx} " if idx2 == 0
        if tile.value == 0
          print "| |"
        else
          print "|#{tile.to_s}|"
        end
      end
      puts ""
    end
  end

  def solved?
    rows_solved?(grid) && columns_solved? && squares_solved?
  end

  def rows_solved?(grid)
    0.upto(8) do |i|
      return false if grid[i].inject("") {|total, char| total += char.value.to_s}.chars.sort.join != "123456789"
    end
      true
  end

  def columns_solved?
    rows_solved?(@grid.dup.transpose)
  end

  def squares_solved?
    i = 0
    while i < 9
      j = 0
      while j < 9
        return false unless square_checker(i, j)
        j += 3
      end
      i += 3
    end
      true
  end

  def square_checker(x, y)
    i = x
    checker_array = []
    while i < x + 3
      j = y
      while j < y + 3
        checker_array << @grid[i][j].value.to_s
        j += 1
      end
      i += 1
    end
    checker_array.sort.join == "123456789"
  end
end
