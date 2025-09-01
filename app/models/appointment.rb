class Appointment < ApplicationRecord
 belongs_to :barbershop
  belongs_to :branch
  belongs_to :barber
  belongs_to :customer
  belongs_to :treatment
  
  enum status: { pending: "pending", confirmed: "confirmed", canceled: "canceled" }
  
  validates :start_time, presence: true
  validates :end_time, presence: true
  
  # Validar que end_time sea posterior a start_time
  validate :end_time_after_start_time
  
  # Validar que el barber trabaje en la sucursal seleccionada
  validate :barber_works_in_branch
  # Validar que el treatment esté disponible en la sucursal
  validate :treatment_available_in_branch
  
  private
  
  def end_time_after_start_time
    return unless start_time && end_time
    
    if end_time <= start_time
      errors.add(:end_time, "debe ser posterior a la hora de inicio")
    end
  end
  
  def barber_works_in_branch
    return unless barber && branch
    
    unless barber.branches.include?(branch)
      errors.add(:barber, "no trabaja en la sucursal seleccionada")
    end
  end
  
  def treatment_available_in_branch
    return unless treatment && branch
    
    unless treatment.branch == branch
      errors.add(:treatment, "no está disponible en la sucursal seleccionada")
    end
  end
end

