class Building < ApplicationRecord
  belongs_to :company
  has_many :meeting_rooms, inverse_of: :building, dependent: :destroy

  accepts_nested_attributes_for :meeting_rooms, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
