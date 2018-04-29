require 'nextcloud/folder'
require 'nextcloud/note'

class Nextcloud < Location
  def read(path)
    root = NcRoot.new
    root.setup(self)
    Folder.add_root root
  end
end
