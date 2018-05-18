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

  private

  def root()       @meta[:root];     end
end

class GwRoot < GwFolder
  def path()   Pathname name;   end
  def root()   self;            end
end
