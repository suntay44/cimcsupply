class AddUpcToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :upc, :string
  end
end
