class AddMissingFieldsToModels < ActiveRecord::Migration[7.2]
  def change
    # Ya tienes start_time y end_time como datetime, pero agregar appointment_date puede ser útil
    unless column_exists?(:appointments, :appointment_date)
      add_column :appointments, :appointment_date, :date
      # Poblar con datos existentes si hay appointments
      execute "UPDATE appointments SET appointment_date = DATE(start_time) WHERE appointment_date IS NULL"
      change_column_null :appointments, :appointment_date, false
    end
    
    # Agregar campos a barbers si no existen
    unless column_exists?(:barbers, :email)
      add_column :barbers, :email, :string, null: false
      add_index :barbers, [:barbershop_id, :email], unique: true
    end
    
    unless column_exists?(:barbers, :active)
      add_column :barbers, :active, :boolean, default: true
    end
    
    # Agregar campos a customers si no existen  
    unless column_exists?(:customers, :email)
      add_column :customers, :email, :string, null: false
      add_index :customers, [:barbershop_id, :email], unique: true
    end
    
    # Agregar campos a treatments si no existen
    unless column_exists?(:treatments, :duration)
      add_column :treatments, :duration, :integer, null: false, comment: "Duración en minutos"
    end
    
    unless column_exists?(:treatments, :price)
      add_column :treatments, :price, :decimal, precision: 10, scale: 2, null: false
    end
    
    unless column_exists?(:treatments, :active)
      add_column :treatments, :active, :boolean, default: true
    end
    
    # Agregar campos a barbershops si no existen
    unless column_exists?(:barbershops, :email)
      add_column :barbershops, :email, :string, null: false
      add_index :barbershops, :email, unique: true
    end
  end
end
