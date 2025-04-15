class RemoveColumnsToMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :user_id, :bigint
    remove_column :messages, :animal_id, :bigint
  end
end
