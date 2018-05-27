require 'nextcloud/nc_folder'
require 'nextcloud/nc_note'
require 'nextcloud/nc_tag'
require 'nextcloud/nc_database'

class Nextcloud < Location
  def read # (path)
    root = NcRoot.new
    root.setup(self)
    Folder.add_root root
    NcTag.read
  end
end
