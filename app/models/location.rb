include CSON

class Location
  attr_accessor :name, :path
  @@done = false


  def self.locations
    Rails.configuration.notes
  end

  def self.class_of(name)
      name.downcase.camelcase.constantize
  end

  def self.read_all

    return if @@done

    Folder.reset
    Note.reset
    Tag.reset

    locations.each do |data|
      (name, type, path) = data

      path = Pathname(path).expand_path
      plugin = class_of type
      plugin.new(name, path) if plugin

    end

    @@done = true

  end

  def initialize(name,path)
    @name = name
    @path = path
    read(path)
  end

end
