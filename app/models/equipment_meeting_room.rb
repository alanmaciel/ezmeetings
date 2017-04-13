class EquipmentMeetingRoom < ApplicationRecord
  belongs_to :equipment
  belongs_to :meeting_room

  accepts_nested_attributes_for :equipment, reject_if: :all_blank
end
