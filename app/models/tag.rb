### to be reimplemented as tree!
class Tag
  attr_accessor :name, :id

  def initialize(name)
    @id = next_id
    @name = name
    @@all << self
  end


  def text()        name;     end    # tree display

  def next_id
    @@last_id +=1
  end

  def self.find_by_path path   #  = by name   / path  is TBD
    all.find {|t| t.name == path}
  end


  def self.all
    @@all
  end

  def self.reset
    @@last_id = 0
    @@all = []
  end

  def self.add_by_name(tagNames)
    tagNames.each do |name|
      Tag.new(name)
    end

  end

  def self.top
    @@top ||= TopTag.new
    @@top
  end

  def children
    []
  end



end

class TopTag < Tag

  def initialize
  end

  def name()  "Tags";   end

  def children
    @@all
  end

end
