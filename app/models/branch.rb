class Branch < ApplicationRecord
  belongs_to :barbershop
  has_many :appointments
  has_many :barber_branches
  has_many :barbers, through: :barber_branches
  has_many :treatments
  
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  
  scope :active, -> { where(active: true) }
end
