class SudokuGame
  attr_accessor :board

  def initialize
    @board = Board.new()
  end

  def self.play(filename="")
    @board = Board.from_file(filename)
    until @board.solved?
      system("clear")
      @board.render
      position = self.player_prompt_pos
      new_value = self.player_prompt_value
      p "#{@board.grid[position[0]][position[1]]} is #{new_value}"
      @board.grid[position[0]][position[1]].value = new_value
    end
    puts "YOU WON"
  end

    def self.player_prompt_pos
      puts "ENTER A POSITION DOG"
      is_valid = false
      until is_valid
        position = gets.chomp.split(", ").map(&:to_i)
        is_valid = (0..8).include?(position[0]) && (0..8).include?(position[1])
      end
      position
    end

      def self.player_prompt_value
        puts "ENTER A VALUE DOG"
        input = gets.chomp.to_i
      end
end
