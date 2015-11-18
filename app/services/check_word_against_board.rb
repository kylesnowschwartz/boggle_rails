class CheckWordAgainstBoard
  POSITIONS = [
    [0,0], [0,1], [0,2], [0,3],
    [1,0], [1,1], [1,2], [1,3],
    [2,0], [2,1], [2,2], [2,3],
    [3,0], [3,1], [3,2], [3,3],
  ]
  X_MIN, Y_MIN = 0, 0
  X_MAX, Y_MAX = POSITIONS.length, POSITIONS.length
  
  def initialize(word, board)
    @word = word
    @board = board
  end

  def call
    if @word.length <= 4
      check_horizontal(@word)
      check_vertical(@word)
    end
  end

  def check_whole_board(word)
    @grid ||= @board.board
    @letters ||= @word.word.chars
    @letters_to_check = @letters.dup
    @current_path = []
    @checked_letters = []

    @letters.each do |letter| # for each letter in the word
      POSITIONS.each do |position| # look through all the cells of the grid for the letter
        row, col = position[0], position[1]
        
        @current_path += position

        if @grid[row][col] == letter # if you found the letter
          until check_neighbors_for_letter(@current_path.last, @letters_to_check.first).empty?# check that positions neighbors for the next letter
            check_neighbors_for_letter(@current_path.last, @letters_to_check.first)
          end
        end
      end
    end
    # TODO
    # for each cell in the board 
      # check if that cell contains the first letter
    # for all of the neighboring positions
      # check at each neighboring position to see if what's there is equal to the next letter in the word
        # if it is? move to that position, subtract from the positions to check where we just came from, and then check it's neighbors for the next letter in the word... repeat
        # if it's not? remove that position from the positions to check
    @checked_letters.join == @word.word
  end

  def check_neighbors_for_letter(position, letter)
    @current_path << position # mark where you found it
    neighbors_to_check = neighbors(position) - @current_path
    neighbors_containing_letter = []

    neighbors_to_check.each do |neighbor|
      p @grid[neighbor[0]][neighbor[1]]
      if @grid[neighbor[0]][neighbor[1]] == letter
        @checked_letters << @letters_to_check.shift # take off that letter from the letters to check

        neighbors_containing_letter << neighbor
      end
    end

    neighbors_containing_letter
  end

  def neighbors(position)
    x_pos = position[0]
    y_pos = position[1]
    
    neighboring_coordinates = []

    (-1..1).each do |i|
      neighboring_coordinates << [(x_pos + i).abs, (y_pos + i).abs].map { |n| n < 4 ? n : 3 }
      neighboring_coordinates << [(x_pos).abs, (y_pos + i).abs].map { |n| n < 4 ? n : 3 }
      neighboring_coordinates << [(x_pos + i).abs, (y_pos).abs].map { |n| n < 4 ? n : 3 }
      neighboring_coordinates << [(x_pos + i).abs, (y_pos - i).abs].map { |n| n < 4 ? n : 3 }
      neighboring_coordinates << [(x_pos - i).abs, (y_pos + i).abs].map { |n| n < 4 ? n : 3 }
    end

    neighboring_coordinates.uniq - [position]
  end

  def positions_to_check(word)
    pos_to_check = []
    letter_to_check = word.chars.first

    POSITIONS.each do |pos|
      if @grid[pos[0]][pos[1]] == letter_to_check
        pos_to_check << pos
      end
    end

    pos_to_check
  end

  def check_horizontal(word)
    n = 0
    4.times do
      return true if @board.board[n].join.include?(word)
      n += 1
    end
  end

  def check_vertical(word)
    n = 0
    4.times do
      return true if transpose_board[n].join.include?(word)
      n += 1
    end
  end

  def transpose_board
    @board.board.transpose
  end
end

# class Grid
#   attr_reader :cells

#   def initialize(board)
#     @board = board
#     @cells = []
#   end

#   def populate_cells
#     @board.board.each do |row|
#       index_of_row = @board.board.index(row)

#       row.each do |cell|
#         index_of_col = row.index(cell)

#         @cells << Cell.new(index_of_row, index_of_col)
#       end
#     end
#   end
# end

# class Cell
#   attr_reader :x_pos, :y_pos

#   def initialize(x_pos, y_pos)
#     @x_pos = x_pos
#     @y_pos = y_pos
#   end
# end


