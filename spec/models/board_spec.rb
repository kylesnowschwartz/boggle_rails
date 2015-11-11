require 'rails_helper'

RSpec.describe Board, type: :model do
  subject { Board.new }

  describe "the board has tiles" do
    it "is a string 16 digits in length" do
      expect(subject.tiles.count).to eq(16)
    end
  end
end
