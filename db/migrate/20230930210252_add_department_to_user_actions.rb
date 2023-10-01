class AddDepartmentToUserActions < ActiveRecord::Migration[7.0]
  def change
    add_column :user_actions, :department_id, :integer
  end
end
