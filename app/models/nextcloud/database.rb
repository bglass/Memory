class NextCloudDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection NEXTCLOUD_DB

  def self.dump
    connection
    all.as_json
  end

end

class NcNoteTagLinkTable < NextCloudDbBase
  self.table_name = "noteTagLink"
end

class NcTagTable < NextCloudDbBase
  self.table_name = "tag"
end
