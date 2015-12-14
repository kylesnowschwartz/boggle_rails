class ValidateWords
  attr_reader :words, :board

  PATH = File.join(Rails.root, 'app', 'assets', 'boggle_words.txt')
  DICTIONARY = File.readlines(PATH).map { |word| word.chomp }

  def initialize(words, board)
    @words = words
    @board = board
  end

  def call
    validated_words = {
      valid_words: [],
      invalid_words: []
    }
    
    words.each do |word| 
      if DICTIONARY.include?(word.word) && CheckWordAgainstBoard.new(word.word, board).call 
        validated_words[:valid_words] << word
      else 
        validated_words[:invalid_words] << word
      end
    end

    validated_words
  end
end