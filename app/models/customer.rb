class Customer < ApplicationRecord
  belongs_to :barbershop
  belongs_to :user
  has_many :appointments
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: :barbershop_id }
end
