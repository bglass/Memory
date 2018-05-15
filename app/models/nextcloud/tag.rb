class NcTag < Tag

  def name()    @tag["name"];     end
  def date()    @tag["created"];  end
  def color()   @tag["color"];    end


  def self.read
    NcDbTag.dump.each do |tag|
      x = NcTag.new(tag)
      binding.pry
      # NcDbTag.all[3].nc_db_note_tag
    end
  end

  def initialize(tag)
    super(tag["name"])
    @tag = tag
  end

end
