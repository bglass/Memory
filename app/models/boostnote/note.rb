class BnNote < Note

  def initialize(note)
    @note = note
    @note[:id] = @@all.size
    @@all << self
    Tag.add_by_name @note["tags"]
  end

  def id()        @note[:id];           end
  def date()      @note["createdAt"];   end
  def type()      @note["type"];        end
  def folder()    @note["folder"];      end
  def content()   @note["content"];     end
  def tags()      @note["tags"];        end
  def starred?()  @note["isStarred"];   end
  def deleted?()  @note["isTrashed"];   end
  def title()     @note["title"];       end
  def name()      title;                end
end


class BnSnippet < BnNote
    def content()   @note["snippets"].to_s;     end
end
