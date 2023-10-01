class AddStatusToUserActions < ActiveRecord::Migration[7.0]
  def change
    add_column :user_actions, :ended_quantity, :integer
  end
end
