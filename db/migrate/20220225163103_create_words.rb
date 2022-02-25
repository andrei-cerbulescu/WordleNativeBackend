class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :word
      t.integer :thumbs_up
      t.integer :thumbs_down

      t.timestamps
    end
  end
end
