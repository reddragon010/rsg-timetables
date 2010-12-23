class RoomsController < ApplicationController
  # GET /rooms
  # GET /rooms.xml
  def index
    @rooms = Room.order(:short).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.xml
  def show
    @room = Room.find(params[:id])
    
    @tt_rows = Array.new
    (1..16).each do |i|
      entries = @room.entries.map{|e| e if e.lession == i}.compact
      schooldays = ["monday","thuesday","wendnesday","thursday","friday","saturday"]
      @tt_rows[i] = Hash.new
      @tt_rows[i]["lession"] = i
      @tt_rows[i]["days"] = Array.new
      schooldays.each_with_index do |day,di|
        @tt_rows[i]["days"] << entries.map{|e| {:subject => e.subject, :teachers => e.teachers, :klass => e.klass} if e.schoolday == day}.compact
      end
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # PUT /rooms/1
  # PUT /rooms/1.xml
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to(@room, :notice => 'Room was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end
end
