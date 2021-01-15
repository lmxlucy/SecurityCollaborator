class ChangeMessageTypeOnMessages < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :alerts, :text, default: ""
    change_column :messages, :reminders, :text, default: ""
    change_column :messages, :device_alerts, :text, default: ""
    change_column :messages, :device_reminders, :text, default: ""
  end
end
