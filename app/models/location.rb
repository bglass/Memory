include CSON

class Location
  attr_accessor :name, :path
  @@done = false

  def initialize(meta)
    @meta = meta
    read # (path)
  end

  def path()    @meta[:path];   end
  def name()    @meta[:name];   end


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

      plugin = class_of type

      path = Pathname(path).expand_path
      if path.directory?
        plugin.new(name: name, path: path) if plugin
      end

    end

    @@done = true

  end

end
