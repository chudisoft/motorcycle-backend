class RemoveNameToMotorcycles < ActiveRecord::Migration[7.1]
  def change
    remove_column :motorcycles, :name, :string
  end
end
