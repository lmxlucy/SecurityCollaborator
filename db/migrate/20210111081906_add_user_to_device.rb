class AddUserToDevice < ActiveRecord::Migration[6.0]
  def change
    add_reference :devices, :user, null: false, foreign_key: true, index: true
  end
end
