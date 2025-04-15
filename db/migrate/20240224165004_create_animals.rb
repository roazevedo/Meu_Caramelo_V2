class CreateAnimals < ActiveRecord::Migration[7.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.integer :age
      t.string :size
      t.string :gender
      t.boolean :vaccination
      t.boolean :neutered
      t.string :story
      t.string :city
      t.string :specie
      t.string :state

      t.timestamps
    end
  end
end
