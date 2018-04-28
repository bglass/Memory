class NoteController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @notes = Note.read
    render "notes/index"
  end

  def view
    @note = Note.find(params[:id])
    render "notes/view"
  end

end
