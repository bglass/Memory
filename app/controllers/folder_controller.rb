class FolderController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    Location.read_all
    @folders = Folder.top
    render "folders/index"
  end

end
