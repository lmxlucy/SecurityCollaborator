class ChangePerfectTypeOnMessages < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :perfect, :text, default: ""
  end
end
