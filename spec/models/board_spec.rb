require 'rails_helper'

RSpec.describe Board, type: :model do
  subject { Board.create! }

  xdescribe "the board has letters" do
    it "is a string 16 digits in length" do
      subject.shake!
      expect(subject.letters.length).to eq 16
    end
  end

  xdescribe "#new_board" do
    it "returns an array with 4 rows each with length 4" do
      expect(subject.new_board![0].length).to eq 4
      expect(subject.new_board![1].length).to eq 4
      expect(subject.new_board![2].length).to eq 4
      expect(subject.new_board![3].length).to eq 4
    end
  end
end
