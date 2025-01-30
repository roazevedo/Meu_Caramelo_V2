class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :integer
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :age, :integer
    add_column :users, :size, :string
    add_column :users, :gender, :string
    add_column :users, :vaccination, :boolean
    add_column :users, :neutered, :boolean
    add_column :users, :specie, :string
    add_column :users, :adopter, :boolean
  end
end
