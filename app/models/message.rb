class Message < ApplicationRecord
  belongs_to :user
  serialize :alerts, Array
  serialize :reminders, Array
  serialize :device_alerts, Array
  serialize :device_reminders, Array
end
