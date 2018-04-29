class NcTag < Tag

  def name()    @tag["name"];     end
  def date()    @tag["created"];  end
  def color()   @tag["color"];    end


  def self.read
    NcTagTable.dump.each do |tag|
      NcTag.new(tag)
    end
  end

  def initialize(tag)
    @tag = tag
    @@all << self
  end

end
