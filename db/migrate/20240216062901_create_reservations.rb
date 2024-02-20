class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :city
      t.references :motorcycle, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.time :reserve_time
      t.date :reserve_date
      t.timestamps
    end
  end
end
