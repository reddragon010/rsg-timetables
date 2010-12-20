class AddColorToSubjects < ActiveRecord::Migration
  def self.up
    add_column :subjects, :color, :string
  end

  def self.down
    remove_column :subjects, :color
  end
end
