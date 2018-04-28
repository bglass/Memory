include CSON

class Note

  def self.read
    @@all = []
    Tag.reset
    NoteBoostNote.read
    @@all
  end

  def self.all
    @@all
  end

  def self.find(id)
    read unless defined? @@all
    @@all[id.to_i]
  end

  def raw()   @note;   end

end


class NoteBoostNote < Note


  def initialize(note)
    @note = note
    @note[:id] = @@all.size
    @@all << self
    Tag.add @note["tags"]
  end

  def id()        @note[:id];           end
  def date()      @note["createdAt"];   end
  def type()      @note["type"];        end
  def folder()    @note["folder"];      end
  def title()     @note["title"];       end
  def content()   @note["content"];     end
  def tags()      @note["tags"];        end
  def starred?()  @note["isStarred"];   end
  def deleted?()  @note["isTrashed"];   end

  def self.read

    files = []
    Rails.configuration.boostnote.values.each do |path|
      files.push *Dir.glob(path + "/notes/*")
    end

    files.each do |file|
      note = CSON.load_file file
      case note["type"]
      when "MARKDOWN_NOTE"
        NoteBoostNote.new(note)
      when "SNIPPET_NOTE"
        NoteBoostSnippet.new(note)
      else
        binding.pry
      end
    end
  end
end

class NoteBoostSnippet < NoteBoostNote
    def content()   @note["snippets"].to_s;     end
end
