# db/migrate/20250830132000_devise_create_users.rb
class DeviseCreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      ## Devise fields
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Perfil
      t.string :name, null: false

      ## Roles
      t.integer :role, null: false, default: 0
      # 0 = super_admin (SaaS)
      # 1 = owner (dueño barbería)
      # 2 = barber
      # 3 = client

      ## Trackable, Recoverable, etc.
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
