class NoteController < ActionController::Base
  # protect_from_forgery with: :exception

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

  def display
    selected = params[:selected]
    @note = Note.find params[:selected].first.to_i

    WebsocketRails[:channel_name].trigger(:event_name, "Hallo!")

    render "notes/view"
  end


end
