
class Folder
  attr_accessor :children, :id

  def text()        name;     end    # tree display


  def initialize(meta = {})
    @id = next_id
    @meta = meta
    @children = []
  end

  def next_id
    @@last_id +=1
  end

  def self.top()    @@top;     end
  def color()       "#000000"; end

  def self.reset
    @@last_id = 0
    @@top ||= TopFolder.new
  end
  def self.add_root(folder)
    @@top.children << folder
  end
  def add_child(folder)
    @children << folder
  end

end

class TopFolder < Folder  # Parent of all root folders
  def name()  "Folders";   end
  def path()  "/";         end
end
