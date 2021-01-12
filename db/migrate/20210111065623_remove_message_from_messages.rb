class RemoveMessageFromMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :message, :text
  end
end
