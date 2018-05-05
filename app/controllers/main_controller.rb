class MainController < ActionController::Base
  protect_from_forgery with: :exception

  def view
    Location.read_all
    @folders  = Folder.top
    @tags     = Tag.all
    @notes    = Note.all
    render "main/grid"
  end

end
