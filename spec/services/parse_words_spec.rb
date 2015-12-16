require 'rails_helper'

RSpec.describe ParseWords, type: :service do
  let(:board) { CreateBoard.new.call }
  let(:words) { "asdf \n game\r    blErp123~~~" }
  subject { ParseWords.new(words, board) }

  describe "#call" do
    it "adds 3 words to the database" do
      expect{ subject.call }.to change{ Submission.count }.by 3
      expect(Submission.last(3)).to eq(Submission.where(board_id: board.id))
    end
  end
end