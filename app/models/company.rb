class Company < ApplicationRecord
  belongs_to :user
  has_many :buildings, dependent: :destroy

  validates :name, presence: true
end
