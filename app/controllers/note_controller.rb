class NoteController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    Location.read_all
    @notes = Note.all
    render "notes/index"
  end

  def view
    Location.read_all
    @note = Note.find(params[:id])
    render "notes/view"
  end

end
