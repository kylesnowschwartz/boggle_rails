class Word < ActiveRecord::Base
  belongs_to :board

  def length
    word.length
  end
end
