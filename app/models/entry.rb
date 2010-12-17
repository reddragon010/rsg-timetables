class Entry < ActiveRecord::Base
  has_and_belongs_to_many :rooms
  has_and_belongs_to_many :teachers
  belongs_to :klass
  belongs_to :subject
end
