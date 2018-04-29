class NcNote < Note

  attr_accessor :id, :title, :path

  def raw()       {};                   end   # development only
  def content()   path.read;            end
  def name()      path.basename.to_s;   end

  def self.create(node)
    case node.extname.downcase
    when ".md", ".txt"
      NcNote.new.setup(node)
    end
  end

  def title_of(text)
    content.lines.first.sub /^#*\s*/, ""
  end

  def setup(node)
    @path    = node
    @title   = title_of content
    @id      = @@all.size
    @@all << self
  end

end
