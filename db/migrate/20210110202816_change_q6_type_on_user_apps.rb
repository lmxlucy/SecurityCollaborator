class ChangeQ6TypeOnUserApps < ActiveRecord::Migration[6.0]
  def change
    change_column :user_apps, :q6, :text, array: true
  end
end
