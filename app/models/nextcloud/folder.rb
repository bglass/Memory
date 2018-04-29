class NcRoot < Folder

  def name()
    @folder["location"].name
  end

  def path()
    @folder["location"].path
  end

  def setup(location)
    @folder = {"location" => location}
  end



  def create_tree
    @children = create_children
  end

  def create_children
    subdirs = path.children.select {|c| c.directory?}

    subdirs.map do |dir|
      child = NcFolder.new
      child.setup(dir)
      child
    end
  end
end



class NcFolder < NcRoot

  def path()     @path;                end
  def name()     path.basename;        end
  def key()      @folder["key"];       end
  def color()    @folder["color"];     end


  def setup(dir)
    @path = dir
    @children = create_children
  end

end
