class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_one :partner, :class_name => 'User', :foreign_key => 'partner_id'
    belongs_to :partner, :class_name => 'User', optional: true
    has_many :user_apps, dependent: :destroy
    has_many :apps, through: :user_apps
    has_many :messages, dependent: :destroy
    accepts_nested_attributes_for :apps
    accepts_nested_attributes_for :user_apps
    
    scope :alphabetical, -> { order('email') }
    scope :singles, -> { where('partner_id IS NULL') }
    
    def possible_partners
      User.all.select { |a| a.partner_id  == self.id }
    end
end
