class ChangeAgeTypeInAnimals < ActiveRecord::Migration[7.1]
  def change
    change_column :animals, :age, :string
  end
end
