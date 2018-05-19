class NcFolder < Folder

  attr_accessor :root, :relative_path, :name

  def path
    root.path + relative_path
  end

  def fs_path
    root.fs_path + relative_path rescue binding.pry
  end

  def setup(this_fs_path, root)
    @root          = root
    @relative_path = this_fs_path.relative_path_from @root.fs_path
    @name          = this_fs_path.basename.to_s
    create_children
  end

  def create_children
    # binding.pry
    fs_path.children.each do |node|
      case
      when node.directory?
        child = NcFolder.new
        child.setup(node, root)
        @children << child
      when node.file?
        NcNote.create(node, root)
      end
    end
  end
end

class NcRoot < NcFolder

  attr_accessor :path, :fs_path

  def root
    self
  end

  def name()
    @meta["location"].name
  end

  def setup(location)
    @meta = {"location" => location}
    @fs_path = location.path
    @path    = Pathname.new(name)
    create_children
  end

end
