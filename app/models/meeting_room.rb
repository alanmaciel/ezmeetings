class MeetingRoom < ApplicationRecord
  has_many :reservations
  belongs_to :building

  validates :name, presence: true
  validates :capacity, presence: true

  def available?(begin_date, end_date)
    available = true
    self.reservations.each do |reservation|
      verify_range = (reservation.begin_at.to_datetime..reservation.ends_at.to_datetime)
      result_begin = verify_range.cover?(begin_date)
      result_end = verify_range.cover?(end_date)
      available = false if result_begin || result_end
    end
    available
  end
end
