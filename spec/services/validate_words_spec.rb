require 'rails_helper'

RSpec.describe ValidateWords, type: :service do
  let (:letters) { "PEELIRKSERRDSCUM"}
  let(:board) { Board.create!(letters: letters) }
  let(:parser) { ParseWords.new(words, board).call }
  subject { ValidateWords.new() }

  describe "call" do
    before do
      @parser = parser
    end

    context "a single word" do
      let(:words) { "LEER" }

      it "validates a single valid word" do
        expect(ValidateWords.new(board.words, board).call).to eq( {
          valid_words: ["LEER"],
          invalid_words: []
        })
      end
    end

    context "multiple words" do
      let(:words) { "LEER RIPE LEEKS" }

      it "validates 3 valid words" do
        expect(ValidateWords.new(board.words, board).call).to eq( {
          valid_words: ["LEER", "RIPE", "LEEKS"],
          invalid_words: []
        })
      end
    end

    context "multiple and invalid words" do
      let(:words) { "LEER RIPE LEEKS ASDF 123 BLERG CLOWNZZZ" }
      
      it "validates 3 valid and invalid words" do
        expect(ValidateWords.new(board.words, board).call).to eq( {
          valid_words: ["LEER", "RIPE", "LEEKS"],
          invalid_words: ["ASDF", "BLERG", "CLOWNZZZ"]
        })
      end
    end
  end
end