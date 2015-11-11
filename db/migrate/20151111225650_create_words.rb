class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.integer :length
      t.references :board
      t.timestamps null: false
    end
  end
end
