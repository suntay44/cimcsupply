class CreateIncidents < ActiveRecord::Migration[7.0]
  def change
    create_table :incidents do |t|
      t.string :title
      t.text :description
      t.string :severity
      t.string :status

      t.timestamps
    end
  end
end
