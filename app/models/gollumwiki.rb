require 'gollumwiki/gw_folder'
require 'gollumwiki/gw_note'
# require 'gollumwiki/gw_page'


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
