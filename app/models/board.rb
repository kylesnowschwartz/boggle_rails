class Board < ActiveRecord::Base
  has_many :submissions, dependent: :destroy

  validates :letters, presence: true
  validate :board_size_is_a_square_number

  def width
    Math.sqrt(letters.size).to_i
  end

  private

  def board_size_is_a_square_number
    sqrt = Math.sqrt(letters.size)

    if sqrt != sqrt.floor
      errors.add(:letters, "can't be a non-square number")
    end
  end
end