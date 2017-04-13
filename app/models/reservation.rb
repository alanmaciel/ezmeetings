# coding: utf-8
class Reservation < ApplicationRecord

  belongs_to :meeting_room

  validates :meeting_room_id, presence: true
  validates :title, presence: true

  def self.get_begin_date(params)
    ("#{params[:search][:begin_at][:year]}-#{params[:search][:begin_at][:month]}-#{params[:search][:begin_at][:day]} 
      #{params[:search][:begin_at][:hour]}:#{params[:search][:begin_at][:minute]}").to_datetime
  end

  def self.get_end_date(params)
    ("#{params[:search][:ends_at][:year]}-#{params[:search][:ends_at][:month]}-#{params[:search][:ends_at][:day]} 
      #{params[:search][:ends_at][:hour]}:#{params[:search][:ends_at][:minute]}").to_datetime
  end

  def self.get_meeting_rooms(building_id, attendees)
    attendees = 0 if attendees == ''
    MeetingRoom.where("building_id = ? AND capacity >= ?", building_id, attendees)
  end

  def self.get_meeting_rooms_with_equipment(req_equipments, meeting_rooms)
    mrs = []
    meeting_rooms.each do |mr|
      mr.equipments.each do |e|
        if req_equipments.include?(e.id)
          mrs << mr
        end
      end
    end
    mrs.uniq
  end

  def self.search(params)
    start_date = get_begin_date(params)
    ends_date = get_end_date(params)

    building_id = params[:search][:building_id]
    attendees = params[:search][:attendees]
    equipments = params[:search][:equipment_id]
    equipments = equipments.reject { |c| c.empty? }
    equipments = equipments.map(&:to_i)

    meeting_rooms1 = get_meeting_rooms(building_id, attendees)
    meeting_rooms = get_meeting_rooms_with_equipment(equipments, meeting_rooms1) 
    available_meeting_rooms = []
    meeting_rooms.each do |meeting_room|
      available_meeting_rooms << meeting_room if meeting_room.available?(start_date, ends_date)
    end
    @search_result = available_meeting_rooms
  end
end
