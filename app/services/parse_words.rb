require 'thread'
class ParseWords
  attr_reader :board, :words

  def initialize(words, board)
    @words = words
    @board = board
  end

  def call
    # TODO lock/mutex seems complicated and requires a bunch of copy pasted code I don't understand, so ask about it
    # Lock.aquire("create-words-lock") do
      split_words.
        map { |word| normalize_word(word) }.
        reject { |word| word == "" }.
        each do |word| 
          board.words.create!(word: word) unless board.words.map(&:word).include?(word)
        end
    # end
  end

  def split_words
    words.split(/\s+/)
  end

  def normalize_word(word)
    word.upcase.gsub(/[^A-Z]/, "")
  end
end