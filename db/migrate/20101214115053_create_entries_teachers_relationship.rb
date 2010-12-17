class CreateEntriesTeachersRelationship < ActiveRecord::Migration
  def self.up
    create_table :entries_teachers, :id => false do |t|
      t.integer :entry_id
      t.integer :teacher_id
    end
  end

  def self.down
    drop_table :entries_teachers
  end
end
