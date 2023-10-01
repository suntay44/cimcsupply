class CreateSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :supplies do |t|
      t.string :name
      t.string :brand
      t.text :description
      t.integer :quantity
      t.timestamp :expiration
      t.integer :user_id

      t.timestamps
    end
  end
end
