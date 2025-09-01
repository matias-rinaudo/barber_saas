class CreateBarberBranches < ActiveRecord::Migration[7.2]
  def change
    create_table :barber_branches do |t|
      t.references :barber, null: false, foreign_key: true
      t.references :branch, null: false, foreign_key: true
      t.timestamps
    end
    
    # Evitar duplicados
    add_index :barber_branches, [:barber_id, :branch_id], unique: true
    add_index :barber_branches, [:branch_id, :barber_id]
  end
end
