class RenameTypeToSupplyTypeColumnInSupply < ActiveRecord::Migration[7.0]
  def change
    rename_column :supplies, :type, :supply_type
  end
end
