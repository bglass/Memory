class NcNote < Note

  # attr_accessor :id, :title,

  attr_accessor :relative_path, :root

  def path
    root.path + relative_path
  end

  def fs_path
    root.fs_path + relative_path rescue binding.pry
  end



  def initialize(this_fs_path, root)
    super()
    @root          = root
    @relative_path = this_fs_path.relative_path_from root.fs_path
    @title   = title_of content
  end

  def raw()       {};                   end   # development only
  def content()   fs_path.read;            end
  def name()      path.basename.to_s;   end

  def self.create(node, root)
    case node.extname.downcase
    when ".md", ".txt"
      NcNote.new(node, root)
    end
  end

  def title_of(text)
    headline = text.lines.first
    headline.sub! /^#*\s*/, ""
    headline.chomp
  end


end
