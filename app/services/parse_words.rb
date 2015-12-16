class ParseWords
  attr_reader :board, :words

  def initialize(words, board)
    @words = words
    @board = board
  end

  def call
    board.with_lock do
      normalized_words = normalize_words(split_words)

      words_without_blanks = reject_blank_words(normalized_words)

      filtered_words = filter_duplicate_words(words_without_blanks)
      
      filtered_words.each { |word| board.submissions.create!(word: word) }
    end
  end

  private

  def filter_duplicate_words(words_with_duplicates)
    words_with_duplicates.select { |word| !board.submissions.map(&:word).include?(word)}
  end

  def split_words
    words.split(/\s+/)
  end

  def normalize_words(words_to_normalize)
    words_to_normalize.map { |word| word.upcase.gsub(/[^A-Z]/, "") }
  end

  def reject_blank_words(words_with_blanks)
    words_with_blanks.reject(&:blank?)
  end
end