class CreateAppointments < ActiveRecord::Migration[7.2]
  def change
    create_table :appointments do |t|
      t.references :barbershop, null: false, foreign_key: true
      t.references :barber, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :treatment, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :status, default: "pending"
      t.timestamps
    end
  end
end