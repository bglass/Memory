require 'boostnote/folder'
require 'boostnote/note'

class Boostnote < Location

  def read(path)
    read_folders(path)
    read_notes(path)
  end

  def read_folders(path)
    file = File.read(path + "/boostnote.json")
    data = JSON.parse(file)
    data["location"] = self
    root = BnRoot.create(data)
    Folder.add_root root
  end

  def read_notes(path)
    Note
    files = Dir.glob(path + "/notes/*")

    files.each do |file|
      note = CSON.load_file file
      case note["type"]
      when "MARKDOWN_NOTE"
        BnNote.create(note)
      when "SNIPPET_NOTE"
        BnSnippet.create(note)
      else
        binding.pry
      end
    end
  end
end
