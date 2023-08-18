class AddReporterAtToIncident < ActiveRecord::Migration[7.0]
  def change
    add_column :incidents, :reporter, :string
  end
end
