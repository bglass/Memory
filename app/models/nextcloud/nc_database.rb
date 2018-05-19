class NcDatabase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection NEXTCLOUD_DB

  def self.dump
    connection
    all.as_json
  end
end

class NcDbNoteTag < NcDatabase
  belongs_to :nc_db_tag, foreign_key: 'tag_id'
  self.table_name = "noteTagLink"
end

class NcDbTag < NcDatabase
  has_many :nc_db_note_tag, foreign_key: 'tag_id'
  self.table_name = "tag"
end
