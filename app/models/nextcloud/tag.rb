class NcTag < Tag

  def name()    @tag["name"];     end
  def date()    @tag["created"];  end
  def color()   @tag["color"];    end
  def nc_id()   @tag["id"];       end

    def self.read
      NcDbTag.dump.each do |tag|
      end
    end

    def initialize(tag)
      super(tag["name"])
      @tag = tag
    end

  end
