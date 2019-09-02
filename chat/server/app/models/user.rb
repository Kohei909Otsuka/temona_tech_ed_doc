class User < ApplicationRecord
  has_many :rooms, through: :user_rooms
  has_many :msgs
  has_many :unread_msgs

  validates :name, presence: true
end
