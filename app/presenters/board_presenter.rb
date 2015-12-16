class BoardPresenter
  def initialize(board)
    @board = board
  end

  def call
    gridify_board(@board)
  end

  private

  def gridify_board(board)   
    grid = board.letters.chars.in_groups_of(4)

    grid.map { |row| qs_to_qus(row) }
  end

  def qs_to_qus(grid_row)
    grid_row.map { |letter| letter.gsub("Q", "Qu") }
  end
end