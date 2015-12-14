class ScoreWords
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def call
    Word.transaction do
      board.words.each do |word|
        word.update!(score: score_word(word)) if word.score.nil?
      end
    end
  end

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