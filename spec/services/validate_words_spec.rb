require 'rails_helper'

RSpec.describe ValidateWords, type: :service do
  let(:board) { CreateBoard.new.call}
  let(:words) { "TOAST" }
  let(:parser) { ParseWords.new(words, board).call }
  subject { ValidateWords.new() }

  describe "call" do
    before do
      @parser = parser
    end

    context "a single word" do
      it "validates a single valid word" do
        expect(ValidateWords.new(board.words).call).to eq( {
          valid_words: ["TOAST"],
          invalid_words: []
        })
      end
    end

    context "multiple words" do
      let(:words) { "TOAST BIRD ZYGOTE" }

      it "validates 3 valid words" do
        expect(ValidateWords.new(board.words).call).to eq( {
          valid_words: ["TOAST", "BIRD", "ZYGOTE"],
          invalid_words: []
        })
      end
    end

    context "multiple and invalid words" do
      let(:words) { "TOAST BIRD ZYGOTE ASDF 123 BLERG CLOWNZZZ" }
      
      it "validates 3 valid and invalid words" do
        expect(ValidateWords.new(board.words).call).to eq( {
          valid_words: ["TOAST", "BIRD", "ZYGOTE"],
          invalid_words: ["ASDF", "BLERG", "CLOWNZZZ"]
        })
      end
    end
  end
end