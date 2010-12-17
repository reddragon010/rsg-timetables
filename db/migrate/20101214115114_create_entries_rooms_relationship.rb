class CreateEntriesRoomsRelationship < ActiveRecord::Migration
  def self.up
    create_table :entries_rooms, :id => false do |t|
      t.integer :entry_id
      t.integer :room_id
    end
  end

  def self.down
    drop_table :entries_rooms
  end
end
