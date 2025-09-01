class AddPerformanceIndexes < ActiveRecord::Migration[7.2]
  def change
    # Agregar el índice appointment_date después de que la columna exista
    add_index :appointments, [:branch_id, :appointment_date] if column_exists?(:appointments, :appointment_date)
    
    # Índices para mejorar consultas comunes
    add_index :appointments, [:barbershop_id, :status] unless index_exists?(:appointments, [:barbershop_id, :status])
    add_index :appointments, [:barber_id, :start_time] unless index_exists?(:appointments, [:barber_id, :start_time])
    add_index :appointments, [:customer_id, :start_time] unless index_exists?(:appointments, [:customer_id, :start_time])
    
    add_index :barbers, [:barbershop_id, :active] unless index_exists?(:barbers, [:barbershop_id, :active])
    add_index :treatments, [:barbershop_id, :active] unless index_exists?(:treatments, [:barbershop_id, :active])
    add_index :branches, [:barbershop_id, :name] unless index_exists?(:branches, [:barbershop_id, :name])
    
    # Índice compuesto para la tabla de unión
    add_index :barber_branches, :created_at unless index_exists?(:barber_branches, :created_at)
  end
end
