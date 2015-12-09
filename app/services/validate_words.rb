class ValidateWords
  attr_reader :words, :board_letters

  PATH = File.join(Rails.root, 'app', 'assets', 'boggle_words.txt')
  DICTIONARY = File.readlines(PATH).map { |word| word.chomp }

  def initialize(words, board)
    @words = words
    @board_letters = board.letters
  end

  def call
    validated_words = {
      valid_words: [],
      invalid_words: []
    }
    
    words.pluck("word").each do |word| 
      if DICTIONARY.include?(word) && CheckWordAgainstBoard.new(word, board_letters).call 
        validated_words[:valid_words] << (word + " " + ScoreWord.new(word).call.to_s)
      else 
        validated_words[:invalid_words] << word
      end
    end

    validated_words
  end
end