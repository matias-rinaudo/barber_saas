class Barbershop < ApplicationRecord
  has_many :users
  has_many :branches, dependent: :destroy
  has_many :barbers, -> { where(role: :barber) }, class_name: "User"
  has_many :appointments, through: :branches
  has_many :treatments, through: :branches
  has_many :subscriptions
  
  has_many :owners, -> { where(role: :owner) }, class_name: "User"
  has_many :customers, -> { where(role: :customer) }, class_name: "User"
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  # Método para obtener todas las citas de todas las sucursales
  def all_appointments
    Appointment.joins(:branch).where(branches: { barbershop_id: id })
  end
  
  # Método para obtener barberos que trabajan en una sucursal específica
  def barbers_in_branch(branch_id)
    barbers.joins(:barber_branches).where(barber_branches: { branch_id: branch_id })
  end
  
  # Método para obtener barberos disponibles para asignar a sucursales
  def available_barbers_for_branch(branch_id)
    branch = branches.find(branch_id)
    barbers.where.not(id: branch.barber_ids)
  end
end


