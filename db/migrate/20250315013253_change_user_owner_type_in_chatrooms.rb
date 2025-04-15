class ChangeUserOwnerTypeInChatrooms < ActiveRecord::Migration[7.1]
  def change
    change_column :chatrooms, :user_owner, 'integer USING user_owner::integer', null: false
  end
end
