class ChangePerfectTypeToMessages < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :perfect, :string, :default => ""
  end
end
