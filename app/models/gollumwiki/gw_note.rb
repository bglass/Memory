class GwNote < Note

  attr_accessor :fs_path

  def initialize(fs_path, parent_folder)
    super()
    @folder   = parent_folder
    @filename = fs_path.basename
  end

  def path
    @folder.path
  end

  def name
    filename.basename filename.extname
  end

  def filename
    @filename
  end

  def date
    "n/a"
  end

  def content()   (@folder.fs_path/filename).read;    end

end
