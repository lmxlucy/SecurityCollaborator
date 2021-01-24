class Device < ApplicationRecord
    belongs_to :user, :inverse_of => :device
    # serialize :q1, Array
end
