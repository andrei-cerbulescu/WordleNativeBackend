class AddLastWordToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_word_id, :integer
  end
end
