class CreateAdoptionForms < ActiveRecord::Migration[7.1]
  def change
    create_table :adoption_forms do |t|
      t.string :query
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
