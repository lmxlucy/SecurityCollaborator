class App < ApplicationRecord
    has_many :user_apps, dependent: :destroy
    has_many :users, through: :user_apps
    validates :name, presence: true, uniqueness: { case_sensitive: false }, allow_nil: true
end
