require 'rails_helper'

RSpec.describe ValidateWords, type: :service do
  let(:word) { ["TOAST"] }
  let(:words) { ["TOAST", "BIRD", "ZYGOTE"] }
  let(:words_with_invalid_words) { ["TOAST", "BIRD", "ZYGOTE", "ASDF", "BLERG", "CLOWNZZZ"] }
  subject { ValidateWords.new()}

  describe "call" do
    it "validates a single valid word" do
      expect(ValidateWords.new(word).call).to eq( {
        valid_words: ["TOAST"],
        invalid_words: []
      })
    end

    it "validates 3 valid words" do
      expect(ValidateWords.new(words).call).to eq( {
        valid_words: ["TOAST", "BIRD", "ZYGOTE"],
        invalid_words: []
      })
    end

    it "validates 3 valid and invalid words" do
      expect(ValidateWords.new(words_with_invalid_words).call).to eq( {
        valid_words: ["TOAST", "BIRD", "ZYGOTE"],
        invalid_words: ["ASDF", "BLERG", "CLOWNZZZ"]
      })
    end
  end
end