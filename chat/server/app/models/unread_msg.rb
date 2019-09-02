class UnreadMsg < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :msg
end
