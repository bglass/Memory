class NoteController < TreeController

  def top()           Note.top;         end

  def data_fields
    [:tags, :path, :date]
  end

  def view
    Location.read_all
    @note = Note.find(params[:id])
    render "notes/view"
  end

  def book
    respond_to :json
    Location.read_all
    @notes = Note.map params[:selected]

    collection = @notes.map do |note|
      {
        date:     note.date,
        tags:     note.tags,
        path:     note.path,
        html:     note.html
      }
    end
    render json: collection
  end

end
