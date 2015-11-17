class Board < ActiveRecord::Base
  has_many :words, dependent: :destroy

  def board
    board = []

    letters_with_qus = qs_to_qus(letters)
    
    4.times { board << letters_with_qus.shift(4) }
    
    board
  end

  private

  def qs_to_qus(string)
    string.chars.map{ |letter| letter == "Q" ? "Qu" : letter }
  end
end


