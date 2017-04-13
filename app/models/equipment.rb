class Equipment < ApplicationRecord
  has_many :equipment_meeting_rooms, inverse_of: :equipment
  has_many :meeting_rooms, through: :equipment_meeting_rooms
end
