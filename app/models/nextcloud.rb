require 'nextcloud/folder'
require 'nextcloud/note'

class Nextcloud < Location

  def read(path)
    read_folders(path)
    # read_notes(path)
  end

  def read_folders(path)
    # Folder.add_root NcRoot.create(self)
  end




  # def read_notes(path)
  #   Note
  #   files = Dir.glob(path + "notes/*")
  #
  #   files.each do |file|
  #     note = CSON.load_file file
  #     case note["type"]
  #     when "MARKDOWN_NOTE"
  #       BnNote.create(note)
  #     when "SNIPPET_NOTE"
  #       BnSnippet.create(note)
  #     else
  #       binding.pry
  #     end
  #   end
  # end
end
