class AddBranchToTreatments < ActiveRecord::Migration[7.2]
  def change
    add_reference :treatments, :branch, null: false, foreign_key: true
    
    # Agregar índices
    add_index :treatments, [:branch_id, :active] if column_exists?(:treatments, :active)
    add_index :treatments, :name
  end
end
