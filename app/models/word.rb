class Word < ActiveRecord::Base
  validates :word, presence: true
  belongs_to :board

  def length
    word.length
  end
end
