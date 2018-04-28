
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


class FolderBoostNoteRoot < Folder

  def name()
    @folder["location"].name;
  end


  def self.create(data)
    children_data = data.delete "folders"
    root = FolderBoostNoteRoot.new(data)

    children_data.each do |child_data|
      child_data["parent"] = root
      child = FolderBoostNote.new(child_data)
      root.add_child child
    end
    root
  end

end

class FolderBoostNote < FolderBoostNoteRoot

  def key()      @folder["key"];       end
  def color()    @folder["color"];     end
  def name()     @folder["name"];      end
end
