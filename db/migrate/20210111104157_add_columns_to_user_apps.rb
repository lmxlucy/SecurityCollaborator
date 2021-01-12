class AddColumnsToUserApps < ActiveRecord::Migration[6.0]
  def change
    add_column :user_apps, :q1_improved, :string
    add_column :user_apps, :q2_improved, :string
    add_column :user_apps, :q3_improved, :string
    add_column :user_apps, :q4_improved, :string
    add_column :user_apps, :q5_improved, :string
  end
end
