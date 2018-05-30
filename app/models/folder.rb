
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

  def self.find_by_path path
    node = top
    path.each_filename do |part|
      node = node.children.find {|n| n.name == part} rescue binding.pry
    end
    node
  end

  # def note_ids
  #   Note.all.select {|n| path == n.path }.map {|n| n.id.to_s}
  # end


end

class TopFolder < Folder  # Parent of all root folders
  def name()  "Top Folder";   end
  def path()  "/";         end
end
