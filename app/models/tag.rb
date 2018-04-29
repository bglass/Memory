require 'set'

class Tag
  attr_accessor :name

  def self.all
    @@all
  end

  def self.reset
    @@all = Set[]
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


end
