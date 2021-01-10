class UserApp < ApplicationRecord
  belongs_to :user
  belongs_to :app
  Q_OPTIONS = ['Yes', 'No', "I don't know"]
end
