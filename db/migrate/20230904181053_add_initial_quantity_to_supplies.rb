class AddInitialQuantityToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :initial_quantity, :integer
  end
end
