require 'rails_helper'

RSpec.describe SubmissionsController, type: :controller do
  let(:board) { CreateBoard.new.call}
  let(:word) { "toast" }
  let(:valid_submission_params) { { board_id: board.id, submission: { words: word } } }

  before :each do
    Board.destroy_all
    Submission.destroy_all
  end

  describe "create" do
    before do
      post :create, valid_submission_params
    end

    it "creates a new word" do
      expect(board.submissions.pluck("word")).to include "TOAST" 
    end
  end
end
