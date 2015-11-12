require 'rails_helper'

RSpec.describe CreateBoard do
  subject { CreateBoard.new.call }

  it "is a valid board" do
    expect(subject).to be_valid
    expect(subject).to be_persisted
    expect(Board.last.letters.length).to eq 16
  end
end
