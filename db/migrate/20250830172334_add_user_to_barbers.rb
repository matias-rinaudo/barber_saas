class AddUserToBarbers < ActiveRecord::Migration[7.2]
  def change
    add_reference :barbers, :user, null: false, foreign_key: true
  end
end
