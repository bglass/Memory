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
        LocationBoostNote.new(name, path)
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

class LocationBoostNote < Location


  def read(path)
    read_folders(path)
    read_notes(path)
  end

  def read_folders(path)
    file = File.read(path + "/boostnote.json")
    data = JSON.parse(file)
    data["location"] = self
    root = FolderBoostNoteRoot.create(data)
    Folder.add_root root
  end

  def read_notes(path)
    Note
    files = Dir.glob(path + "/notes/*")

    files.each do |file|
      note = CSON.load_file file
      case note["type"]
      when "MARKDOWN_NOTE"
        Noteboostnote.create(note)
      when "SNIPPET_NOTE"
        NoteBoostSnippet.create(note)
      else
        binding.pry
      end
    end
  end
end
