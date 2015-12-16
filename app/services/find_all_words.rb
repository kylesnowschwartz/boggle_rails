class FindAllWords
  def initialize(board)
    @board = board
    @valid_starting_letters = @board.letters.chars.uniq
    @dictionary_subset = prune_dictionary(ValidateWords::DICTIONARY)
  end

  def call
    @dictionary_subset.map do |word|
      CheckWordAgainstBoard.new(word, @board).call
    end.select(&:present?).sort_by(&:length)
  end

  def prune_dictionary(dictionary)
    @valid_starting_letters.map do |letter|
      dictionary.select { |word| word.first == letter }
    end.flatten 
  end
end