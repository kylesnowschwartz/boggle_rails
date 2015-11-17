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

  def check_whole_board(word)
    grid ||= @board.board
    letters ||= word.chars
    positions_to_check = []
    letter_to_check = letters.shift
    # TODO
    # for each cell in the board 
      # find all the positions of the board which contain the first letter of the word to check
    POSITIONS.each do |pos|
      if grid[pos[0]][pos[1]] == letter_to_check
        positions_to_check << pos
      end
    end

    positions_to_check.each do |pos|
      neighbors_to_check = neighbors(pos) - checked_neighbors
    end
    # for all of the neighboring positions of that first letter inside the constraints of the board
      # check at each neighboring position to see if what's there is equal to the next letter in the word
        # if it is? move to that position, subtract from the positions to check where we just came from, and then check it's neighbors for the next letter in the word... repeat
        # if it's not? remove that position from the positions to check
  end

  def neighbors(x_pos, y_pos)
    grid = @board.board
    coordinates = []

    (-1..1).each do |cell|

    end
  end

  def check_letter_for_neighbor(letter, neighbor)
    grid = @board.board

    grid.each do |row|
      if row.include?(letter)
        index_of_row = grid.index(row)
        col = row.index(letter)
        
        [ 
          grid[index_of_row+1][col], 
          grid[index_of_row+1][col+1], 
          grid[index_of_row][col+1], 
          grid[index_of_row-1][col+1], 
          grid[index_of_row-1][col], 
          grid[index_of_row][col-1], 
          grid[index_of_row+1][col-1], 
          grid[index_of_row-1][col-1] 
        ].include?(neighbor)
        # TODO maybe a grid class has a row and a column class, and these rows and columns have methods like #next_row and #top_right_neighbor
      end
    end
  end
end

class Grid
  attr_reader :cells

  def initialize(board)
    @board = board
    @cells = []
  end

  def populate_cells
    @board.board.each do |row|
      index_of_row = @board.board.index(row)

      row.each do |cell|
        index_of_col = row.index(cell)

        @cells << Cell.new(index_of_row, index_of_col)
      end
    end
  end
end

class Cell
  attr_reader :x_pos, :y_pos


  def initialize(x_pos, y_pos)
    @x_pos = x_pos
    @y_pos = y_pos
  end
  # grid[index_of_row-1][col+1], 
  # grid[index_of_row-1][col], 
  # grid[index_of_row][col-1], 
  # grid[index_of_row+1][col-1], 
  # grid[index_of_row-1][col-1] 
  def bottom_neighbor
     [(@x_pos + 1) , @y_pos] if (@x_pos + 1).between?(X_MIN, X_MAX)
  end

  def bottom_right_neighbor
     [@x_pos , (@y_pos + 1)] if (@y_pos + 1).between?(Y_MIN, Y_MAX)
  end

  def right_neighbor
     [@x_pos , (@y_pos + 1)] if (@y_pos + 1).between?(Y_MIN, Y_MAX)
  end

  def top_right_neighbor
     [(@x_pos - 1) , (@y_pos + 1] if (@x_pos + 1).between?(X_MIN, X_MAX) && (@y_pos + 1).between?(Y_MIN, Y_MAX)
  end

  def bottom_neighbor
     [(@x_pos + 1) , @y_pos] if (@x_pos + 1).between?(X_MIN, X_MAX)
  end

  def bottom_neighbor
     [(@x_pos + 1) , @y_pos] if (@x_pos + 1).between?(X_MIN, X_MAX)
  end

  def bottom_neighbor
     [(@x_pos + 1) , @y_pos] if (@x_pos + 1).between?(X_MIN, X_MAX)
  end

  def bottom_neighbor
     [(@x_pos + 1) , @y_pos] if (@x_pos + 1).between?(X_MIN, X_MAX)
  end
end

# def check_whole_board(word)
#   grid ||= @board.board
#   letters = word.chars
#   array_of_truth = []
  
#   letters.each do |letter|
#     grid.each do |row|
#       index_of_row = grid.index(row)
#       index_in_letters = letters.index(letter)

#       if row.join.include?(letter)
#         col = row.index(letter)

#         if [grid[index_of_row+1][col], grid[index_of_row+1][col+1], grid[index_of_row][col+1], grid[index_of_row-1][col+1], grid[index_of_row-1][col], grid[index_of_row][col-1], grid[index_of_row+1][col-1], grid[index_of_row-1][col-1]].include?(letters[index_in_letters + 1])
          
#           array_of_truth.push(true)
#           p "array of truth #{array_of_truth}"
#         end
#       end
#     end
#   end

#   array_of_truth.length == letters.length
# end


