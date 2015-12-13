class ParseWords
  attr_reader :board, :words
  def initialize(words, board)
    @words = words
    @board = board
  end

  def call
    # TODO does this need a transaction block?
    split_words.
      map { |word| normalize_word(word) }.
      select { |word| word != "" }.
      each { |word| board.words.create!(word: word) }
  end

  def split_words
    @words.split(/\s+/)
  end

  def normalize_word(word)
    word.upcase.gsub(/[^a-zA-Z]/, "")
  end
end