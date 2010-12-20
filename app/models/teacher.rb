class Teacher < ActiveRecord::Base
  has_and_belongs_to_many :entries
  
  def subjects
    entries.map{|e| e.subject}.uniq
  end
end
