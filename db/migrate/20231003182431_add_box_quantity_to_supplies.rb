class AddBoxQuantityToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :box_quantity, :integer
    add_column :supplies, :qty_per_box, :integer
  end
end
