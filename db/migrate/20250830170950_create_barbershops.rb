class CreateBarbershops < ActiveRecord::Migration[7.2]
  def change
    create_table :barbershops do |t|
      t.string :name, null: false
      t.string :address
      t.string :phone
      t.string :email
      t.timestamps
    end
  end
end