require 'rails_helper'

def transpose_board(board)
  board.map { |row| row.chars }.transpose.map{ |row| row.join }
end

RSpec.describe CheckWordAgainstBoard do
  let(:board) { Board.create!(letters: letters) }
  # let(:word) { Word.create!(word: "LUCK", board_id: board.id) }
  subject { CheckWordAgainstBoard.new(word, board) }

  HORIZONTAL_WORDS = [
    "LUCK",
    "SKIL",
    "LIMB",
    "RIMS"
  ]

  VERTICAL_WORDS = [
    "PEEL",
    "IRKS",
    "ERRD",
    "SCUM"
  ]

  TWO_DIMENSIONAL_WORDS = [
    # "LEER",
    "LEEKS"
    # "RIPE"
  ]

  describe "#check_horizontal" do
    HORIZONTAL_WORDS.each do |row|
      let (:letters) { "LUCKSKILLIMBRIMS"}
      let(:word) { Word.create!(word: row, board_id: board.id) }
    
      it "checks a horizontal word #{row} is in the board" do
        expect(subject.check_horizontal(word.word)).to be true
      end
    end
  end

  describe "#check_vertical" do
    transpose_board(VERTICAL_WORDS).each do |col|
    let(:letters) { "PEELIRKSERRDSCUM" }
    let(:word) { Word.create!(word: col, board_id: board.id) }


      it "checks that a vertical word #{col} is in the board" do
        expect(subject.check_vertical(word.word)).to be true
      end
    end
  end

  describe "#check_whole_board" do
    TWO_DIMENSIONAL_WORDS.each do |word_to_check|
      let(:letters) { "PEELIRKSERRDSCUM" }

      it "checks that a word #{word_to_check} is in the board" do
        w = Word.create!(word: word_to_check, board_id: board.id)
        s = CheckWordAgainstBoard.new(w, board)
        expect(s.check_whole_board(w.word)).to be true
      end
    end
  end
end