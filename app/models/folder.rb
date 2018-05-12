
class Folder
  attr_accessor :children

  def id()  path;   end
  def text()        name;     end    # tree display


  def initialize(data = {})
    @folder = data
    @children = []

    @id = 88

  end

  def self.top()    @@top;     end
  def color()       "#000000"; end

  def self.reset
    @@top ||= TopFolder.new
  end
  def self.add_root(folder)
    @@top.children << folder
  end
  def add_child(folder)
    @children << folder
  end

end

class TopFolder < Folder
  def name()  "Folders";   end
  def path()  "/";         end
end
