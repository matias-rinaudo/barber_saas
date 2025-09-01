class Treatment < ApplicationRecord
  belongs_to :barbershop
  belongs_to :branch
  has_many :appointments
  
  validates :name, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  
  scope :active, -> { where(active: true) }
  scope :available_for_branch, ->(branch_id) { where(branch_id: branch_id, active: true) }
end
