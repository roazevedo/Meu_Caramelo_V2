class AddColunasToAdoptionForm < ActiveRecord::Migration[7.1]
  def change
    add_column :adoption_forms, :pergunta1, :string
    add_column :adoption_forms, :pregunta2, :string
    add_column :adoption_forms, :pergunta3, :string
    add_column :adoption_forms, :pergunta4, :string
    add_column :adoption_forms, :pergunta5, :string
    add_column :adoption_forms, :pergunta6, :string
    add_column :adoption_forms, :pergunta7, :string
    add_column :adoption_forms, :pergunta8, :string
  end
end
