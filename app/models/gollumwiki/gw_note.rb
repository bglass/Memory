include FileSystem
require 'active_support/core_ext/string/output_safety'

class GwNote < Note

  attr_accessor :fs_path, :page, :folder

  def initialize(fs_path, parent_folder)
    super()
    @folder   = parent_folder
    @filename = fs_path.basename
    @page     = @folder.root.wiki.page name.to_s rescue binding.pry
  end

  def resource_name
    stem
  end

  def name
    stem.to_s
  end

  def filename
    @filename
  end

  def wiki
    folder.root.wiki
  end

  def date
    "n/a"
  end

  def content()   binding.pry;    end
  def markdown()  page.text_data;    end


  def html(format = :markdown)
    wiki.preview_page(page.name, page.text_data, format).formatted_data.html_safe
  end

end
