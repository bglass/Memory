class NcRoot < Folder

  def name()
    @folder["location"].name
  end

  def path()
    @folder["location"].path
  end

  def self.create(location)
    folder = {"location" => location}
    NcRoot.new(folder)
  end

  def children
    binding.pry
  end
end

class NcFolder < NcRoot





  def key()      @folder["key"];       end
  def color()    @folder["color"];     end
  def name()     @folder["name"];      end
end
