class ChangeDefaultScoreValueForWords < ActiveRecord::Migration
  def change
    change_column_default :words, :score, nil
  end
end
