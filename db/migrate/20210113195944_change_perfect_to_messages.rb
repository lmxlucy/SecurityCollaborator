class ChangePerfectToMessages < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :perfect, :boolean, :default => false
  end
end
