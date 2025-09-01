class CreateSubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.references :barbershop, null: false, foreign_key: true
      t.string :status, default: "active" # active, paused, canceled
      t.string :mercado_pago_subscription_id
      t.datetime :current_period_start
      t.datetime :current_period_end
      t.timestamps
    end
  end
end