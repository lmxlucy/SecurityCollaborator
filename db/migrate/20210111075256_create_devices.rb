class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.text :q1, array: true, default:[]
      t.string :q2
      t.string :q3
      t.string :q4

      t.timestamps
    end
  end
end
