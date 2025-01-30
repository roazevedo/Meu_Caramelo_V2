class ChangeAgeTypeInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :age, :string
  end
end
