class Building < ApplicationRecord
  belongs_to :company
  has_many :meeting_rooms
end
