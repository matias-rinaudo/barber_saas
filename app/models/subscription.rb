class Subscription < ApplicationRecord
  belongs_to :barbershop
  enum status: { active: "active", paused: "paused", canceled: "canceled" }
end