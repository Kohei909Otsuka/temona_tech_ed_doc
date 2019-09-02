class Msg < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :unread_msgs
end
