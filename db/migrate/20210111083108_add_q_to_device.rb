class AddQToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :q5, :string
    add_column :devices, :q6, :string
  end
end
