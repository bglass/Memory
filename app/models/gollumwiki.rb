require 'gollumwiki/folder'
# require 'gollumwiki/note'
# require 'gollumwiki/tag'
# require 'gollumwiki/database'

class Gollumwiki < Location





  def read
    @meta[:fs_path] = @meta[:path]
    @meta[:path]    = Pathname @meta[:name]

    Folder.add_root GwRoot.new(@meta)
  end

  private

  def fs_path
    @meta[:fs_path]
  end


end
