class RenameWords < ActiveRecord::Migration
  def change
    rename_table :words, :submissions
  end
end
