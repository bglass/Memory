class Tag
  attr_accessor :name

### to be reimplemented as tree!


  def self.all
    @@all
  end

  def self.reset
    @@all = []
  end

  def self.add_by_name(tagNames)
    tagNames.each do |name|
      Tag.new(name)
    end

  end

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.top
    @@top ||= TopTag.new
    @@top
  end

  def children
    []
  end

  def id
    66
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
