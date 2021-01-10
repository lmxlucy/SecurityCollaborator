class AddAccessedTodayToUserApps < ActiveRecord::Migration[6.0]
  def change
    add_column :user_apps, :accessed_today, :boolean
  end
end
