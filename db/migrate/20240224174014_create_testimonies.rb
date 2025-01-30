class CreateTestimonies < ActiveRecord::Migration[7.1]
  def change
    create_table :testimonies do |t|
      t.references :adoption, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
