include CSON

class Location
  attr_accessor :name, :path

  def self.locations
    Rails.configuration.notes
  end


  def self.read_all

    Folder.reset
    Note.reset
    Tag.reset

    locations.each do |data|
      (name, type, path) = data
      case type.downcase
      when "boostnote"
        Boostnote.new(name, path)
      when "nextcloud", "owncloud"
        # LocationNextCloud.new(name, path)
      else
        binding.pry
      end
    end
  end

  def initialize(name,path)
    @name = name
    @path = path
    read(path)
  end

end
