class AddStatusToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :status, :string
  end
end
