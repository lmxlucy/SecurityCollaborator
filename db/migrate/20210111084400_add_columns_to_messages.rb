class AddColumnsToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :device_reminders, :text, array:true
    add_column :messages, :device_alerts, :text, array:true
  end
end
