class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.text :alerts, array:true, default:[]
      t.text :reminders, array: true, default:[]
      t.text :device_reminders, array:true, default:[]
      t.text :device_alerts, array:true, default:[]
      t.string :perfect, default: ""
      t.timestamps
    end
  end
end
