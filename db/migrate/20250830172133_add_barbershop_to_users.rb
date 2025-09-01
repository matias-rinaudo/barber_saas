class AddBarbershopToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :barbershop, foreign_key: true
  end
end
