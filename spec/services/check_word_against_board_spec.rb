require 'rails_helper'

RSpec.describe CheckWordAgainstBoard do
  let(:board) { Board.create!(letters: letters) }
  subject { CheckWordAgainstBoard.new(word, board) }

  WORDS_IN_BOARD_ONE = [
    "LUCK",
    "SKIL",
    "LIMB",
    "RIMS",
    "LUCKLIK",
    "LUCKLIKSLIMBSMIR"
  ]

  WORDS_IN_BOARD_TWO = [
    "PEEL",
    "IRKS",
    "ERRD",
    "SCUM",
    "PEELSKRIERRDMUCS"
  ]

  WORDS_IN_BOARD_THREE = [
    "LEER",
    "LEEKS",
    "RIPE",
    "PRRM",
    "LKRS"
  ]

  WORDS_IN_BOARD_FOUR = [
    "QUEEN",
    "QUIZ",
    "IQUEEN",
    "IQUIZ",
    "AZCDHGIZQIKNEEUM"
  ]

  context "these words are in board one" do
    WORDS_IN_BOARD_ONE.each do |word_to_check|
      let (:letters) { "LUCKSKILLIMBRIMS"}

      it "#{word_to_check}" do
        w = Submission.create!(word: word_to_check, board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board)
        expect(s.call).to eq w.word
      end
    end
  end

  context "these words are in board two" do
    WORDS_IN_BOARD_TWO.each do |word_to_check|
      let(:letters) { "PEELIRKSERRDSCUM" }

      it "#{word_to_check}" do
        w = Submission.create!(word: word_to_check, board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board)
        expect(s.call).to eq w.word
      end
    end
  end

  context "when board has 'Q' words" do
    WORDS_IN_BOARD_FOUR.each do |word_to_check|
      let(:letters) { "AZCDZIGHQIKNMUEE" }

      it "#{word_to_check}" do
        w = Submission.create!(word: word_to_check, board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board)
        expect(s.call).to eq w.word
      end
    end
  end

  context "when board has two dimensional words" do
    context "these words are in the board" do
      WORDS_IN_BOARD_THREE.each do |word_to_check|
        let(:letters) { "PEELIRKSERRDSCUM" }

        it "#{word_to_check}" do
          w = Submission.create!(word: word_to_check, board_id: board.id)
          s = CheckWordAgainstBoard.new(w.word, board)
          expect(s.call).to eq w.word
        end
      end
    end

    context "these words are NOT in the board" do
      let(:letters) { "PEELIRKSERRDSCUM" }

      it "checks that WRONG is NOT in the board" do
        w = Submission.create!(word: "WRONG", board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board)
        expect(s.call).to be nil
      end

      it "checks that 4 disconnected letters is NOT in the board" do
        w = Submission.create!(word: "PMEU", board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board)
        expect(s.call).to be nil
      end

      it "checks that 1234 is NOT in the board" do
        w = Submission.create!(word: "1234", board_id: board.id)
        s = CheckWordAgainstBoard.new(w.word, board)
        expect(s.call).to be nil
      end
    end
  end
end