class Room < ApplicationRecord
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :msgs
  has_many :unread_msgs

  validates :name, presence: true
end
