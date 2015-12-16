class Submission < ActiveRecord::Base
  belongs_to :board

  validates :word, presence: true

  def length
    word.length
  end
end
