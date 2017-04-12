class ChangeCapacityColumnToInteger < ActiveRecord::Migration[5.0]
  def up
    remove_column :meeting_rooms, :capacity
    add_column :meeting_rooms, :capacity, :integer
  end

  def down
    remove_column :meeting_rooms, :capacity
    add_column :meeting_rooms, :capacity, :decimal
  end
end
