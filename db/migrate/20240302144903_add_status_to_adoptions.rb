class AddStatusToAdoptions < ActiveRecord::Migration[7.1]
  def change
    add_column :adoptions, :status, :string
  end
end
