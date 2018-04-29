
class Folder
  attr_accessor :children

  def initialize(data = {})
    @folder = data
    @children = []
  end

  def self.top()    @@top;     end
  def color()       "#000000"; end

  def self.reset
    @@top = FolderTop.new
  end
  def self.add_root(folder)
    @@top.children << folder
  end
  def add_child(folder)
    @children << folder
  end
end

class FolderTop < Folder
  def name()  "Folders";   end
end
