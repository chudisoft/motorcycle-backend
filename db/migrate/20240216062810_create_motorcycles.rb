class CreateMotorcycles < ActiveRecord::Migration[7.1]
  def change
    create_table :motorcycles do |t|
      t.string :name
      t.string :description
      t.string :color
      t.string :image
      t.string :license_plate
      t.boolean :available, default: true
      t.decimal :price, precision: 8, scale: 2
      t.timestamps
      t.references :user, null: false, foreign_key: true
    end

    add_index :motorcycles, :name
    add_index :motorcycles, :color
  end
end
