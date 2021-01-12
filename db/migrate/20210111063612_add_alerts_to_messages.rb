class AddAlertsToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :alerts, :text, array:true
  end
end
