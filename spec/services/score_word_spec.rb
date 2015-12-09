require 'rails_helper'

RSpec.describe ScoreWord do
  let(:one_letter_word)   { "A" }
  let(:two_letter_word)   { "AB" }
  let(:three_letter_word) { "ABC" }
  let(:four_letter_word)  { "ABCD" }
  let(:five_letter_word)  { "ABCDE" }
  let(:six_letter_word)   { "ABCDEF" }
  let(:seven_letter_word) { "ABCDEFG" }
  let(:eight_letter_word) { "ABCDEFGH" }
  let(:nine_letter_word)  { "ABCDEFGHI" }
  let(:ten_letter_word)   { "ABCDEFGHIJ" }

  describe "accurately scoring words" do    
    it "scores a 1 letter word as 0 points" do
      expect(ScoreWord.new(one_letter_word).call).to eq 0
    end

    it "scores a 2 letter word as 0 points" do
      expect(ScoreWord.new(two_letter_word).call).to eq 0
    end

    it "scores a 3 letter word as 1 points" do
      expect(ScoreWord.new(three_letter_word).call).to eq 1
    end

    it "scores a 4 letter word as 1 points" do
      expect(ScoreWord.new(four_letter_word).call).to eq 1
    end

    it "scores a 5 letter word as 2 points" do
      expect(ScoreWord.new(five_letter_word).call).to eq 2
    end

    it "scores a 6 letter word as 3 points" do
      expect(ScoreWord.new(six_letter_word).call).to eq 3
    end

    it "scores a 7 letter word as 5 points" do
      expect(ScoreWord.new(seven_letter_word).call).to eq 5
    end

    it "scores a 8 letter word as 11 points" do
      expect(ScoreWord.new(eight_letter_word).call).to eq 11
    end

    it "scores a 9 letter word as 11 points" do
      expect(ScoreWord.new(nine_letter_word).call).to eq 11
    end

    it "scores a 10 letter word as 11 points" do
      expect(ScoreWord.new(ten_letter_word).call).to eq 11
    end
  end
end