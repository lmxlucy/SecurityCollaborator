class AddDateToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :date, :date
  end
end
