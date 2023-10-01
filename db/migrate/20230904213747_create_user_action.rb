class CreateUserAction < ActiveRecord::Migration[7.0]
  def change
    create_table :user_actions do |t|
      t.string :action
      t.integer :user_id
      t.integer :dispense
      t.integer :supply_id

      t.timestamps
    end
  end
end
