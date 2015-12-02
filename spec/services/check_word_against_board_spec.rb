require 'rails_helper'

RSpec.describe CheckWordAgainstBoard do
  let(:board) { Board.create!(letters: letters) }
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
    "RIPE",
    "PRRM",
    "LKRS"
  ]

  describe "check horizontal words" do
    HORIZONTAL_WORDS.each do |word_to_check|
      let (:letters) { "LUCKSKILLIMBRIMS"}

      it "checks that a word #{word_to_check} is in the board" do
        w = Word.create!(word: word_to_check, board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board.letters)
        expect(s.call).to eq w.word
      end
    end
  end

  describe "check vertical words" do
    VERTICAL_WORDS.each do |word_to_check|
      let(:letters) { "PEELIRKSERRDSCUM" }

      it "checks that a word #{word_to_check} is in the board" do
        w = Word.create!(word: word_to_check, board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board.letters)
        expect(s.call).to eq w.word
      end
    end
  end

  describe "check for two dimensional words" do
    context "these words are in the board" do
      TWO_DIMENSIONAL_WORDS.each do |word_to_check|
        let(:letters) { "PEELIRKSERRDSCUM" }

        it "checks that a word #{word_to_check} is in the board" do
          w = Word.create!(word: word_to_check, board_id: board.id)
          s = CheckWordAgainstBoard.new(w.word, board.letters)
          expect(s.call).to eq w.word
        end
      end
    end

    context "these words are NOT in the board" do
      let(:letters) { "PEELIRKSERRDSCUM" }

      it "checks that WRONG is NOT in the board" do
        w = Word.create!(word: "WRONG", board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board.letters)
        expect(s.call).to be false
      end

      it "checks that 1234 is NOT in the board" do
        w = Word.create!(word: "1234", board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board.letters)
        expect(s.call).to be false
      end
    end
  end
end