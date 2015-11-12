class RemoveLengthFromWords < ActiveRecord::Migration
  def change
    remove_column :words, :length, :integer
  end
end
