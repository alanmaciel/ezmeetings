class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.string :title
      t.datetime :begin_at
      t.datetime :ends_at
      t.references :meeting_room, foreign_key: true

      t.timestamps
    end
  end
end
