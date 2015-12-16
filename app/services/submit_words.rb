class SubmitWords
  def initialize(words, board)
    @words = words
    @board = board
  end

  def call
    ParseWords.new(@words, @board).call

    ScoreWords.new(@board).call
  end
end