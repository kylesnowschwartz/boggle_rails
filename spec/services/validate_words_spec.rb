require 'rails_helper'

RSpec.describe ValidateWords, type: :service do
  let (:letters) { "PEELIRKSERRDSCUM"}
  let(:board) { Board.create!(letters: letters) }
  let(:parser) { ParseWords.new(words, board).call }
  subject { ValidateWords.new }

  describe "call" do
    before do
      @parser = parser
    end

    context "a single valid word" do
      let(:words) { "LEER" }

      it "validates a single valid word" do
        expect(ValidateWords.new(board.submissions, board).call).to eq(
          ValidateWords::ValidatedWords.new(board.submissions.to_a, [])
        )
      end
    end

    context "multiple valid words" do
      let(:words) { "LEER RIPE LEEKS" }

      it "validates 3 valid words" do
        expect(ValidateWords.new(board.submissions, board).call).to eq(
          ValidateWords::ValidatedWords.new(board.submissions.to_a, [])
        )
      end
    end

    context "a single invalid word" do
      let(:words) { "CLOWNZZZ" }

      it "validates a single invalid word" do
        expect(ValidateWords.new(board.submissions, board).call).to eq(
          ValidateWords::ValidatedWords.new([], board.submissions.to_a)
        )
      end
    end

    context "multiple invalid words" do
      let(:words) { "ASDF BLERG CLOWNZZZ" }

      it "validates multiple invalid words" do
        expect(ValidateWords.new(board.submissions, board).call).to eq(
          ValidateWords::ValidatedWords.new([], board.submissions.to_a)
        )
      end
    end
  end
end