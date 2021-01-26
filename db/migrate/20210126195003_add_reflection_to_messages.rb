class AddReflectionToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :self_reflection, :text
    add_column :messages, :joint_reflection, :text
  end
end
