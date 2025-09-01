class User < ApplicationRecord
  belongs_to :barbershop, optional: true
  
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :validatable, :trackable
         
  enum role: { super_admin: 0, owner: 1, barber: 2, customer: 3 }
  
  validates :name, presence: true
  
  after_initialize :set_default_role, if: :new_record?
  after_create :create_customer_profile, if: :customer?
  after_create :create_barber_profile, if: :barber?
  
  # Método para obtener las sucursales donde trabaja el usuario (si es barber)
  def branches
    return Branch.none unless barber?
    barber_profile&.branches || Branch.none
  end
  
  # Método para verificar si trabaja en una sucursal específica
  def works_in_branch?(branch)
    return false unless barber?
    barber_profile&.works_in_branch?(branch) || false
  end
  
  # Métodos para obtener perfiles específicos
  def customer_profile
    Customer.find_by(user: self)
  end
  
  def barber_profile
    Barber.find_by(user: self)
  end
  
  private
  
  def set_default_role
    self.role ||= :customer
  end
  
  def create_customer_profile
    Customer.create!(
      user: self,
      barbershop: barbershop,
      name: name,
      email: email,
      phone: nil
    )
  end
  
  def create_barber_profile
    barber = Barber.create!(
      user: self,
      barbershop: barbershop,
      name: name,
      email: email,
      phone: nil
    )
    
    # Asignar a la primera sucursal disponible por defecto
    # Esto puede modificarse después desde la interfaz
    first_branch = barbershop&.branches&.first
    if first_branch
      barber.branches << first_branch
    else
      Rails.logger.warn "No se pudo asignar sucursal al barbero: no hay sucursales disponibles"
    end
  end
end