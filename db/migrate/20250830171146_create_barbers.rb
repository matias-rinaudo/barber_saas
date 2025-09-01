class CreateBarbers < ActiveRecord::Migration[7.2]
  def change
    create_table :barbers do |t|
      t.references :barbershop, null: false, foreign_key: true
      t.string :name, null: false
      t.string :phone
      t.string :email
      t.timestamps
    end
  end
end
