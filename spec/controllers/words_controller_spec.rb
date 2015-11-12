require 'rails_helper'

RSpec.describe WordsController, type: :controller do
  let(:board) { Board.create!}
  let(:word) { "toast" }
  let(:valid_word_params) { { board_id: board.id, word: word } }

  before :each do
    Board.destroy_all
    Word.destroy_all
  end

  describe "create" do
    before do
      post :create, valid_word_params
    end

    it "creates a new word" do
      expect(Word.find_by(valid_word_params)).to be_truthy
    end
  end
end
