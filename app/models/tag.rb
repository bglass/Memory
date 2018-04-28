require 'set'

class Tag
  attr_accessor :name

  def self.all
    @@all
  end

  def self.reset
    @@all = Set[]
  end

  def self.add(tagNames)
    @@all.merge(tagNames)
  end

end
