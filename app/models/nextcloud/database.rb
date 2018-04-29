class NextCloudDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection NEXTCLOUD_DB
end
