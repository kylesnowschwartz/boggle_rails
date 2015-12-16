require 'rails_helper'

RSpec.describe Submission, type: :model do
  let(:word) { "four" }
  subject { Submission.create!(word: word) }

  describe "#length" do
    it "should count the letters in the word" do
      expect(subject.length).to eq 4
    end
  end
end
