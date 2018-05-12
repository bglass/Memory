class NoteController < TreeController

  def top()           Note.top;         end

  def data_fields()
    [:tags, :path]
  end

  def view
    Location.read_all
    @note = Note.find(params[:id])
    render "notes/view"
  end

  def display
    selected = params[:selected]
    @note = Note.find params[:selected].first.to_i
    render partial: "notes/view"
  end

end
