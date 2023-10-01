class Incident < ApplicationRecord

  def self.resolved
    Incident.where(status: 'resolved')
  end 
end
