include FileSystem

class GwFolder < Folder

  def name()       @meta[:name];     end
  def fs_path()    @meta[:fs_path];  end

  def path
    if self == root
      Pathname name
    else
      root.path + (fs_path.relative_path_from root.fs_path)
    end
  end

  def children
    child_dirs.map do |d|
      GwFolder.new ({fs_path: d, name: d.basename, root: root})
    end
  end

  def set_as_root
    @meta[:root] = self
  end

  private

  def root()       @meta[:root];     end


end
