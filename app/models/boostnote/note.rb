class BnNote < Note

  def initialize(note)
    super()
    @note = note

    Tag.add_by_name @note["tags"]
  end

  def date()      @note["createdAt"];   end
  def type()      @note["type"];        end
  def folder()    @note["folder"];      end
  def content()   @note["content"];     end
  def tags()      @note["tags"];        end
  def starred?()  @note["isStarred"];   end
  def deleted?()  @note["isTrashed"];   end
  def title()     @note["title"];       end
  def name()      title;                end

  



  def path
    # binding.pry
    "unknown"
  end


end


class BnSnippet < BnNote
  def content()   @note["snippets"].to_s;     end
end
