class AddSenderToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :sender, :string
  end
end
