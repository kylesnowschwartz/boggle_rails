class ParseWords
  def initialize(words, board)
    @words = words
    @board = board
  end

  def call
    split_words.
      map { |word| normalize_word(word) }.
      select { |word| word != "" }.
      each { |word| Word.create!(board: @board, word: word) }
  end

  def split_words
    @words.split(/\s+/)
  end

  def normalize_word(word)
    word.upcase.gsub(/[^a-zA-Z]/, "")
  end
end