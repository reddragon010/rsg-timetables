require "open-uri"

class HtlTTExtract
  attr_accessor :url
  attr_reader :classes, :timetable

  def initialize(session,week)
    #defaults
    @TT_MENU_URL = "http://htl17.at/Teatime/schuelerverwaltung/menu_stundenplan.php"
    @TT_URL = "http://htl17.at/Teatime/schuelerverwaltung/stundenplan.php"
    
    #@TT_MENU_URL = "http://htl17.at/Teatime/schuelerverwaltung/menu_stundenplan.php"
    #@TT_URL = "/Users/mriedmann/Sites/stundenplan_4hw.html"
    
    #generate vars
    @timetable = Hash.new
    @teachers = Array.new
    @subjects = Array.new
    @rooms = Array.new
    @cWeek = week
    @cSession = session
    @days = ["","monday","thuesday","wendnesday","thursday","friday","saturday","sunday"]
    #load timetable
    @classes = get_parsed_classes
    @classes.each do |i|
      @timetable[i] = get_parsed_timetable(i)
    end 
  end
  
  def teachers
    @timetable.each do |key,value|
      value.each do |i|
        @teachers << i["teacher"]
      end
    end
    @teachers.flatten!
    @teachers.uniq!
  end
  
  def subjects
    @timetable.each do |key,value|
      value.each do |i|
        @subjects << i["subject"]
      end
    end
    @subjects.flatten!
    @subjects.uniq!
  end
  
  def rooms
    @timetable.each do |key,value|
      value.each do |i|
        @rooms << i["room"]
      end
    end
    @rooms.flatten!
    @rooms.uniq!
  end
  
  protected
  
  def get_parsed_timetable(eClass,eWeek=@cWeek,eSession=@cSession)
    return parse(get_timetable(@TT_URL + "?sessid=#{eSession}&woche=#{eWeek}&klasse=#{eClass}"))
  end
  
  def get_parsed_classes(eSession=@cSession)
    return ["4HW"] if @mock
    return get_classes(@TT_MENU_URL + "?sessid=#{eSession}")
  end

  def get_timetable(url)
    doc = Hpricot(open(url))
    ttable = Array.new
    i = 0
    doc.search("script").each do |op|
      op = op.inner_html
      ttable[i] = Array.new
      ttable[i][0] = op.split(".").first.strip
      block = Hpricot(op)
      ttable[i][1] = block.search("span.fach").inner_html
      ttable[i][1] = block.search("span.fachkl").inner_html if ttable[i][1] == ""
      subblock = block.search("span.lehrsaal").inner_html.strip
      unless subblock == ""
        subblock[0..5] = ""
        subblock = subblock.split("<br />")
        ttable[i][2] = subblock[0].delete "()"
        ttable[i][3] = subblock[1]
      end
      i+=1 unless ttable[i][0] == "" 
    end
    res = Array.new
    ttable.each do |i|
      copy = true
      copy = false if i[0] == nil or i[0] == ""
      copy = false if i[1] == nil or i[1] == ""
      copy = false if i[2] == nil or i[2] == ""
      copy = false if i[3] == nil or i[3] == ""
      res << i if copy
    end
    return res
  end
  
  def get_classes(url)
    doc = Hpricot(open(url))
    site = doc.search("script").inner_html
    cp1 = site.index("var classes = [") + 15
    cp2 = site.index("];") - 1
    parsedSite = site[cp1..cp2]
    parsedSite.delete! "'"
    splitSite = parsedSite.split(",")
    return splitSite
  end

  def parse(ttable)
    table = Array.new
    ttable.each do |i|
      subject = Array.new
      room = Array.new
      teacher = Array.new
      i[0] = i[0].split("s")
      i[0][0].delete!("z")
      day = @days[i[0][1].to_i]
      i[2].chop!
      subject = i[1].split(",") if i[1].index(",")
      room = i[2].split(",") if i[2].index(",")
      teacher = i[3].split(",") if i[3].index(",")
      subject << i[1] if subject.empty?
      room << i[2] if room.empty?
      teacher << i[3] if teacher.empty?
      temp = Hash.new
      temp["hour"] = i[0][0]
      temp["day"] = day
      temp["subject"] = i[1] 
      temp["room"] = room
      temp["teacher"] = teacher 
      table << temp
    end
    return table
  end
end