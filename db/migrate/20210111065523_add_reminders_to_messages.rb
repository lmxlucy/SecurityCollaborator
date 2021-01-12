class AddRemindersToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :reminders, :text, array: true
  end
end
