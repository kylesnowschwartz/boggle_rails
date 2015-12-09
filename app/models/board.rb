class Board < ActiveRecord::Base
  validates :letters, presence: true
  validate :board_size_is_a_square_number
  has_many :words, dependent: :destroy

  def gridify_board   
    4.times.map do 
      qs_to_qus(letters.slice!(0..3).chars)
    end
  end

  private

  def qs_to_qus(array)
    array.map { |letter| letter == "Q" ? "Qu" : letter }
  end

  def board_size_is_a_square_number
    sqrt = Math.sqrt(letters.size)

    if sqrt != sqrt.floor
      errors.add(:letters, "can't be a non-square number")
    end
  end
end