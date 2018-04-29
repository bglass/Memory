include CSON

class Location
  attr_accessor :name, :path

  def self.locations
    Rails.configuration.notes
  end

  def self.class_of(name)
      name.downcase.camelcase.constantize
  end

  def self.read_all

    Folder.reset
    Note.reset
    Tag.reset

    locations.each do |data|
      (name, type, path) = data

      plugin = class_of type
      plugin.new(name, path) if plugin

    end
  end

  def initialize(name,path)
    @name = name
    @path = path
    read(path)
  end

end
