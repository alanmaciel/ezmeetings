class MeetingRoom < ApplicationRecord
  belongs_to :building

  validates :name, presence: true
  validates :capacity, presence: true
end
