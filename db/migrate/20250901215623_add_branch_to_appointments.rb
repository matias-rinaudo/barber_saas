class AddBranchToAppointments < ActiveRecord::Migration[7.2]
  def change
    add_reference :appointments, :branch, null: true, foreign_key: true
    
    # Agregar índices para optimizar consultas (sin appointment_date por ahora)
    add_index :appointments, [:branch_id, :status]
    add_index :appointments, [:branch_id, :barber_id]
    add_index :appointments, [:branch_id, :start_time]
  end
end
