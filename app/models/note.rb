class Note

  def self.reset
    @@all = []
  end

  def self.all
    @@all
  end

  def self.find(id)
    @@all[id.to_i]
  end

  def raw()   @note;   end

end


class Noteboostnote < Note

  def self.create(note)
    this = Noteboostnote.new
    this.setup(note)
  end

  def setup(note)
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
end


class NoteBoostSnippet < Noteboostnote
    def content()   @note["snippets"].to_s;     end
end
