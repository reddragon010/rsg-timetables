require "htl_tt_extract"

class ActualizationsController < ApplicationController
  def index

  end
  
  def new
    
  end
  
  def create
    dd = HtlTTExtract.new(params[:esession][:esession],params[:eweek][:eweek])
    #cleanup
    Room.destroy_all
    Teacher.destroy_all
    Subject.destroy_all
    Klass.destroy_all
    Entry.destroy_all
    #write klasses
    dd.classes.each{|klass| Klass.create(:short => klass)}
    #write rooms
    dd.rooms.each{|room| Room.create(:short => room)}
    #write teachers
    dd.teachers.each{|teacher| Teacher.create(:short => teacher)}
    #write subjects
    dd.subjects.each{|subject| Subject.create(:short => subject)}
    #write entries
    dd.classes.each do |klass|
      #raise dd.timetable[klass].inspect
      dd.timetable[klass].each do |tt|
        entry = Entry.new(:schoolday => tt['day'], :lession => tt['hour'], :klass => Klass.find_by_short(klass), :subject => Subject.find_by_short(tt['subject']))
        tt['teacher'].each do |t|
          entry.teachers << Teacher.find_by_short(t)
        end
        tt['room'].each do |r|
          entry.rooms << Room.find_by_short(r)
        end
        entry.save
      end
    end
    redirect_to :action => :index
  end

end
