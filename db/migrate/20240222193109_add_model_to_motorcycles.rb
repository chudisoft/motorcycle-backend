class AddModelToMotorcycles < ActiveRecord::Migration[7.1]
  def change
    add_column :motorcycles, :model, :string
    add_column :motorcycles, :year, :date
  end
end
