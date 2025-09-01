class CreateTreatments < ActiveRecord::Migration[7.2]
  def change
    create_table :treatments do |t|
      t.references :barbershop, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :duration_minutes, null: false, default: 30
      t.timestamps
    end
  end
end
