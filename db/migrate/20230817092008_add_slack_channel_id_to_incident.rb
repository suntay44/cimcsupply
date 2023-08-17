class AddSlackChannelIdToIncident < ActiveRecord::Migration[7.0]
  def change
    add_column :incidents, :slack_channel_id, :string
  end
end
