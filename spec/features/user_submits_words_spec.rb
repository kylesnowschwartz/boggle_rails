require 'rails_helper'

describe "submit words for validation" do
  let(:board) { CreateBoard.new.call }

  before :each do
    @board = board
    visit "/boards/#{ board.id }"
    fill_in("words_text_area", :with => "toast; beer\n cheese\r 123 apple")
    click_button("Submit Words")
  end

  it "saves those words to the board" do
    expect(board.submissions.pluck("word")).to eq ["TOAST", "BEER", "CHEESE", "APPLE"]
  end
end