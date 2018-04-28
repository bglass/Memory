class Folder
  attr_accessor :children

  def self.read
    @@top = FolderTop.new
    FolderBoostNote.read
  end

  def self.top()    @@top;     end
  def color()       "#000000"; end
end

class FolderTop < Folder
  def initialize
    @children = []
  end
  def name()  "Folders";   end
end

  class FolderBoostNoteRoot < Folder

    def name()     @folder["name"];      end

    def initialize(data)
      children_data = data.delete "folders"
      @children = []
      children_data.each do |child_data|
        child_data["parent"] = self
        child = FolderBoostNote.new(child_data)
        @children << child
      end
      @folder = data
    end
  end

class FolderBoostNote < FolderBoostNoteRoot

  def initialize(data)
    @children = []
    @folder = data
  end

  def key()      @folder["key"];       end
  def color()    @folder["color"];     end

  def self.read
    Rails.configuration.boostnote.each do |name,path|
      file = File.read(path + "/boostnote.json")
      data = JSON.parse(file)
      data["name"] = name
      @@top.children << FolderBoostNoteRoot.new(data)
    end
  end

end
