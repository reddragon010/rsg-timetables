class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string  :schoolday
      t.integer :lession
      t.integer :subject_id
      t.integer :klass_id

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
