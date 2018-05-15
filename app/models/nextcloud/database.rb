class NextCloudDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection NEXTCLOUD_DB
  def self.dump
    connection
    all.as_json
  end

end

class NcDbNoteTag < NextCloudDbBase
  belongs_to :nc_db_tag, class_name: 'NcDbTag'
  self.table_name = "noteTagLink"
end

class NcDbTag < NextCloudDbBase
  has_many :nc_db_note_tag, class_name: 'NcDbNoteTag', foreign_key: 'tag_id'
  self.table_name = "tag"
end
