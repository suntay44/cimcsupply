class Supply < ApplicationRecord
  belongs_to :user
  has_many :user_actions
  enum supply_type: [:medicine, :medical_supply]


  def is_expiring?
    (self.expiration.to_date - Date.today.to_date).to_i <= self.expiration_warning
  end

  def is_critical_supply?
    self.quantity <= self.initial_quantity * 0.10
  end
end
