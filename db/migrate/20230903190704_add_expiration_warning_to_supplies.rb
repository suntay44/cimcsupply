class AddExpirationWarningToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :expiration_warning, :integer
  end
end
