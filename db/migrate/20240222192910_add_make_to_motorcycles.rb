class AddMakeToMotorcycles < ActiveRecord::Migration[7.1]
  def change
    add_column :motorcycles, :make, :string
  end
end
