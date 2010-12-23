class KlassesController < ApplicationController
  # GET /klasses
  # GET /klasses.xml
  def index
    @klasses = Klass.order(:short).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @klasses }
    end
  end

  # GET /klasses/1
  # GET /klasses/1.xml
  def show
    @klass = Klass.find(params[:id])
    @tt_rows = Array.new
    (1..16).each do |i|
      entries = @klass.entries.map{|e| e if e.lession == i}.compact
      schooldays = ["monday","thuesday","wendnesday","thursday","friday","saturday"]
      @tt_rows[i] = Hash.new
      @tt_rows[i]["lession"] = i
      @tt_rows[i]["days"] = Array.new
      schooldays.each_with_index do |day,di|
        @tt_rows[i]["days"] << entries.map{|e| {:subject => e.subject, :teachers => e.teachers, :rooms => e.rooms.map{|r| r.short}} if e.schoolday == day}.compact
      end
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @klass }
    end
  end

  # GET /klasses/1/edit
  def edit
    @klass = Klass.find(params[:id])
  end

  # PUT /klasses/1
  # PUT /klasses/1.xml
  def update
    @klass = Klass.find(params[:id])

    respond_to do |format|
      if @klass.update_attributes(params[:klass])
        format.html { redirect_to(@klass, :notice => 'Klass was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
      end
    end
  end
end
