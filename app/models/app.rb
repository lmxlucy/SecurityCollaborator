class App < ApplicationRecord
    has_many :user_apps, dependent: :destroy
    has_many :users, through: :user_apps
end
