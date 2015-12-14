class AddScoreToWords < ActiveRecord::Migration
  def change
    add_column :words, :score, :integer, default: 0
  end
end
