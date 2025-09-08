class Branch < ApplicationRecord
  belongs_to :barbershop
  has_many :appointments
  has_many :barber_branches
  has_many :barbers, through: :barber_branches
  has_many :treatments
  
  validates :name, :address, :phone, presence: true

  scope :actives, -> { where(active: true) }
end
