class NoteController < TreeController

  def top()           Note.top;         end

  def data_fields
    [:tags, :path]
  end

  def view
    Location.read_all
    @note = Note.find(params[:id])
    render "notes/view"
  end

  def display
    Location.read_all
    selected = params[:selected]
    @note = Note.find params[:selected].first.to_i
    render partial: "notes/view"
  end

  def bookx
    Location.read_all
    @notes = Note.map params[:selected]
    binding.pry
    render partial: "notes/book"
  end

  def book
    respond_to :json
    Location.read_all
    @notes = Note.map params[:selected]

    collection = @notes.map do |note|
      {
        date:     note.date,
        tags:     note.tags,
        folder:   note.folder,
        html:     note.html
      }
    end
    render json: collection
  end

end


# respond_to :json
# Location.read_all
# # x = get_tree top; binding.pry
# render json: get_tree(top)[:children]
