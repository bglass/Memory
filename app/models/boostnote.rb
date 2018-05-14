require 'boostnote/folder'
require 'boostnote/note'

class Boostnote < Location

  def read(path)
    read_folders(path)
    read_notes(path)
  end

  def read_folders(path)
    file = (path / "boostnote.json").read
    data = JSON.parse(file)
    data["location"] = self
    root = BnRoot.create(data)
    Folder.add_root root
  end

  def read_notes(path)
    Note
    files = Pathname.glob(path / "notes/*.cson")
    files.each do |file|
      note = CSON.load_file file
      note["type"] rescue binding.pry
      case note["type"]
      when "MARKDOWN_NOTE"
        BnNote.new(note)
      when "SNIPPET_NOTE"
        BnSnippet.new(note)
      else
        binding.pry
      end
    end
  end
end
