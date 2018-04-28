class FolderController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    Folder.read
    @top = Folder.top
    render "folders/index"
  end

end
