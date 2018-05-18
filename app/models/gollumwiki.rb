require 'gollumwiki/folder'
# require 'gollumwiki/note'
# require 'gollumwiki/tag'
# require 'gollumwiki/database'

class Gollumwiki < Location





  def read
    @meta[:fs_path] = @meta[:path]
    @meta[:path]    = Pathname @meta[:name]

    root = GwFolder.new(@meta)
    root.set_as_root

    Folder.add_root root
  end

  private

  def fs_path
    @meta[:fs_path]
  end


end
