require 'nextcloud/folder'
require 'nextcloud/note'
require 'nextcloud/tag'

class Nextcloud < Location
  def read(path)
    root = NcRoot.new
    root.setup(self)
    Folder.add_root root
    NcTag.read
  end
end
