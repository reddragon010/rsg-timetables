class TeachersController < ApplicationController
  # GET /teachers
  # GET /teachers.xml
  def index
    @teachers = Teacher.order(:short).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teachers }
    end
  end

  # GET /teachers/1
  # GET /teachers/1.xml
  def show
    @teacher = Teacher.find(params[:id])
    @tt_rows = Array.new
    (1..16).each do |i|
      entries = @teacher.entries.map{|e| e if e.lession == i}.compact
      schooldays = ["monday","thuesday","wendnesday","thursday","friday","saturday"]
      @tt_rows[i] = Hash.new
      @tt_rows[i]["lession"] = i
      @tt_rows[i]["days"] = Array.new
      schooldays.each_with_index do |day,di|
        @tt_rows[i]["days"] << entries.map{|e| {:subject => e.subject, :klass => e.klass.short, :rooms => e.rooms.map{|r| r.short}} if e.schoolday == day}.compact
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @teacher }
    end
  end

  # GET /teachers/1/edit
  def edit
    @teacher = Teacher.find(params[:id])
  end

  # PUT /teachers/1
  # PUT /teachers/1.xml
  def update
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to(@teacher, :notice => 'Teacher was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @teacher.errors, :status => :unprocessable_entity }
      end
    end
  end
end
