class ValidateWords
  PATH = File.join(Rails.root, 'app', 'assets', 'boggle_words.txt')
  DICTIONARY = File.readlines(PATH).map { |word| word.chomp }

  def initialize(words)
    @words = words
  end

  def call
    validated_words = {
      valid_words: [],
      invalid_words: []
    }

    @words
      .each { |word| DICTIONARY.include?(word) ? validated_words[:valid_words] << word : validated_words[:invalid_words] << word}

    validated_words
  end
end