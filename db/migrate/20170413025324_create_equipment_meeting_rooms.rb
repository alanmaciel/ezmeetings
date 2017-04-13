class CreateEquipmentMeetingRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment_meeting_rooms do |t|
      t.references :equipment, foreign_key: true
      t.references :meeting_room, foreign_key: true

      t.timestamps
    end
  end
end
