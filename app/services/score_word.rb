class ScoreWord
  attr_reader :word

  def initialize(word)
    @word = word
  end

  def call
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