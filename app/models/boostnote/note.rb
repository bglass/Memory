class BnNote < Note

  def self.create(note)
    this = BnNote.new
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


class BnSnippet < BnNote
    def content()   @note["snippets"].to_s;     end
end
