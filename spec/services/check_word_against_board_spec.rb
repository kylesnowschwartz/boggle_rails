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
    "LEER",
    "LEEKS",
    "RIPE"
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
    let(:letters) { "PEELIRKSERRDSCUM" }
    let (:word) { "LEEKS" }

    it "checks that a word is in the board" do
      expect(subject.check_whole_board(word)).to be true
    end
  end
end