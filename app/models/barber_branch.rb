class BarberBranch < ApplicationRecord
  belongs_to :barber
  belongs_to :branch
  
  validates :barber_id, uniqueness: { scope: :branch_id }
  
  # Validar que el barber y branch pertenezcan a la misma barbershop
  validate :same_barbershop
  
  private
  
  def same_barbershop
    return unless barber && branch
    
    unless barber.barbershop_id == branch.barbershop_id
      errors.add(:base, "El barbero y la sucursal deben pertenecer a la misma barbería")
    end
  end
end