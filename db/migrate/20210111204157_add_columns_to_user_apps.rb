class AddColumnsToUserApps < ActiveRecord::Migration[6.0]
  def change
    add_column :user_apps, :q1_improved, :boolean
    add_column :user_apps, :q2_improved, :boolean
    add_column :user_apps, :q3_improved, :boolean
    add_column :user_apps, :q4_improved, :boolean
    add_column :user_apps, :q5_improved, :boolean
    add_column :user_apps, :q6_mine_improved, :boolean
    add_column :user_apps, :q6_partner_improved, :boolean
    add_column :user_apps, :q6_public_improved, :boolean
  end
end
