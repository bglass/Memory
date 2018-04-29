class NcFolder < Folder

  def path()     @path;                end
  def name()     path.basename;        end


  def setup(dir)
    @path = dir
    create_children
  end

  def create_children
    path.children.each do |node|
      case
      when node.directory?
        child = NcFolder.new
        child.setup(node)
        @children << child
      when node.file?
        NcNote.create(node)
      end
    end
  end

end

class NcRoot < NcFolder

  def name()
    @folder["location"].name
  end

  def setup(location)
    @folder = {"location" => location}
    @path   = @folder["location"].path
    create_children
  end

end
