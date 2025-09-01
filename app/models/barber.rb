class Barber < ApplicationRecord
  belongs_to :barbershop
  belongs_to :user
  has_many :appointments
  has_many :barber_branches, dependent: :destroy
  has_many :branches, through: :barber_branches
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: :barbershop_id }
  
  scope :active, -> { where(active: true) }
  scope :working_in_branch, ->(branch_id) { 
    joins(:barber_branches).where(barber_branches: { branch_id: branch_id }, active: true)
  }
  
  # Método para verificar si el barbero trabaja en una sucursal específica
  def works_in_branch?(branch)
    branches.include?(branch)
  end
  
  # Método para obtener las sucursales donde trabaja el barbero
  def branch_names
    branches.pluck(:name).join(', ')
  end
  
  # Método para agregar una sucursal al barbero
  def add_branch(branch)
    return false unless branch.barbershop == barbershop
    
    branches << branch unless branches.include?(branch)
  end
  
  # Método para remover una sucursal del barbero
  def remove_branch(branch)
    branches.delete(branch)
  end
end
