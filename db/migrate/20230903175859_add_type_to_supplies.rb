class AddTypeToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :type, :integer
  end
end
