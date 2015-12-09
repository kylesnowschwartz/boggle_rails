require 'rails_helper'

RSpec.describe ParseWords, type: :service do
  let(:board) { CreateBoard.new.call }
  let(:words) { "asdf \n game\r     blerp1" }
  subject { ParseWords.new(words, board) }

  describe "#split_words" do
    it "splits a string up by white space characters" do
      expect(subject.split_words).to eq ["asdf", "game", "blerp1"]
    end
  end

  describe "#normalize word" do
    it "strips out non-letter characters and upcases" do
      expect(subject.normalize_word("blerp123~~~")).to eq "BLERP"
    end
  end

  describe "#call" do
    it "adds 3 words to the database" do
      expect{ subject.call }.to change{ Word.count }.by 3
      expect(Word.last(3)).to eq(Word.where(board_id: board.id))
    end
  end
end