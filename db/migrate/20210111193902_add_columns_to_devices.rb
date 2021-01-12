class AddColumnsToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :q1_improved, :boolean
    add_column :devices, :q1_improved_2, :boolean
    add_column :devices, :q2_improved, :boolean
    add_column :devices, :q3_improved, :boolean
    add_column :devices, :q4_improved, :boolean
    add_column :devices, :q5_improved, :boolean
    add_column :devices, :q6_improved, :boolean
  end
end
