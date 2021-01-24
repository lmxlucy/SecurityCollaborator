class UserApp < ApplicationRecord
  belongs_to :user
  belongs_to :app
  # serialize :q6, Array
end
