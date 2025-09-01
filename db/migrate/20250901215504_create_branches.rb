class CreateBranches < ActiveRecord::Migration[7.2]
  def change
    create_table :branches do |t|
      t.references :barbershop, null: false, foreign_key: true
      t.string :name, null: false
      t.string :address, null: false
      t.string :phone, null: false
      t.string :email
      t.text :description
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.json :working_hours # Para almacenar horarios de trabajo
      t.boolean :active, default: true
      t.timestamps
    end
    
    add_index :branches, [:barbershop_id, :active]
    add_index :branches, :name
  end
end
