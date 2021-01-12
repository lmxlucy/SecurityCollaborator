class RemoveDateFromMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :date, :date
  end
end
