require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:word) { "four" }
  subject { Word.create!(word: word) }

  describe "#length" do
    it "should count the letters in the word" do
      expect(subject.length).to eq 4
    end
  end
end
