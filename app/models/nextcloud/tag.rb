require 'nextcloud/database'


class NcNoteTagLink < NextCloudDbBase
  self.table_name = "noteTagLink"
    connection
    binding.pry
end

class NcTag < NextCloudDbBase
  self.table_name = "tag"

  def self.read
    connection
    binding.pry
  end


end
