class GwNote < Note

  attr_accessor :fs_path, :page

  def initialize(fs_path, parent_folder)
    super()
    @folder   = parent_folder
    @filename = fs_path.basename
    @page  = Page.find_or_initialize_by_name name
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


  def content()   page.preview;    end

end
