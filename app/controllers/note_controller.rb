class NoteController < TreeController


  def top()    Note.top;  end


  def view
    Location.read_all
    @note = Note.find(params[:id])
    render "notes/view"
  end


end
