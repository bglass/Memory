class GwNote < Note

  attr_accessor :fs_path, :page

  def initialize(fs_path, parent_folder)
    super()
    @folder   = parent_folder
    @filename = fs_path.basename
    @page  = GwPage.find_or_initialize_by_name name
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

  def content()   binding.pry;    end
  def markdown()  binding.pry; end

  # def content()   page.preview;    end
  # def markdown()  Markdown.new content; end
  def html()      page.preview;     end

end
