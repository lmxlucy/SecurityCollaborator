class CreateUserApps < ActiveRecord::Migration[6.0]
  def change
    create_table :user_apps do |t|
      t.references :user, null: false, foreign_key: true
      t.references :app, null: false, foreign_key: true
      t.string :q1
      t.string :q2
      t.string :q3
      t.string :q4
      t.string :q5
      t.text :q6, array: true, default: []
      t.boolean :accessed_today

      t.timestamps
    end
  end
end
