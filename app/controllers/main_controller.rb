class MainController < ActionController::Base
  protect_from_forgery with: :exception

  def view
    Location.read_all
    @tagroot  = Folder.top
    @tags     = Tag.all
    @notes    = Note.all
    render "main/view"
  end

end
