class Board < ActiveRecord::Base
  has_many :words, dependent: :destroy

  def board
    board = []

    a = qs_to_qus(letters)
    
    4.times { board << a.shift(4) }
    
    board
  end

  def qs_to_qus(string)
    string.chars.map{ |letter| letter == "Q" ? "Qu" : letter }
  end
end


