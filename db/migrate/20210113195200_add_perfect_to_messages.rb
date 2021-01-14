class AddPerfectToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :perfect, :boolean
  end
end
