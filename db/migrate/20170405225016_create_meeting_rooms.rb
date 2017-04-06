class CreateMeetingRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :meeting_rooms do |t|
      t.string :name
      t.decimal :capacity
      t.references :building, foreign_key: true

      t.timestamps
    end
  end
end
