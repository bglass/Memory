include FileSystem

class GwFolder < Folder

  def name()       @meta[:name];     end
  def fs_path()    @meta[:fs_path];  end

  def path
    root.path + (fs_path.relative_path_from root.fs_path) rescue binding.pry
  end

  def children
    child_dirs.map do |d|
      GwFolder.new ({fs_path: d, name: d.basename, root: root})
    end
  end

  def find_notes
    child_files.each { |f| GwNote.new(f, self)}
  end

  private

  def root()       @meta[:root];     end
end

class GwRoot < GwFolder

  attr_accessor :wiki

  def initialize(meta)
    super
    @wiki = Gollum::Wiki.new(fs_path, base_path: name)

    find_notes
  end



  def path()   Pathname name;   end
  def root()   self;            end
end
