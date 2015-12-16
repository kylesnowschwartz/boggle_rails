class ScoreWords
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def call
    board.submissions.
      select { |word| word.score.nil? }.
      each { |word| word.update!(score: score_word(word)) }
  end

  private

  def score_word(word)
    case word.length
    when 0..2
      0
    when 3..4
      1
    when 5
      2
    when 6
      3
    when 7
      5
    else
      11      
    end
  end
end