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
binding.pry
    # WebsocketRails[:channel_name].trigger(:event_name, "Hallo!")
    DisplayChannel.broadcast_to(
        "tags",
        id: 15,
        html: "Was soll das?"
      )


    render "notes/view"
  end


end
