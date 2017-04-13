class MeetingRoom < ApplicationRecord
  has_many :reservations
  belongs_to :building

  has_many :equipment_meeting_rooms, inverse_of: :meeting_room
  has_many :equipments, through: :equipment_meeting_rooms, class_name: 'Equipment'

  accepts_nested_attributes_for :equipments
  accepts_nested_attributes_for :equipment_meeting_rooms, allow_destroy: true

  validates :name, presence: true
  validates :capacity, presence: true

  def available?(begin_date, end_date)
    available = true
    reservations.each do |reservation|
      verify_range = (reservation.begin_at.to_datetime..reservation.ends_at.to_datetime)
      result_begin = verify_range.cover?(begin_date)
      result_end = verify_range.cover?(end_date)
      available = false if result_begin || result_end
    end
    available
  end

end
