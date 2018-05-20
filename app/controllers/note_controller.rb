class NoteController < TreeController

  def top()           Note.top;         end

  def data_fields
    [:tags, :path, :date, :filename]
  end

  def view
    Location.read_all
    @note = Note.find(params[:id])
    render "notes/view"
  end

  def book
    respond_to :json
    Location.read_all

    if selected = params[:selected]
      @notes = Note.map selected

    elsif paths = params[:paths]
      @notes = Note.find_by_paths paths

    else @notes = []
    end

    fields = [:id, :date, :tags, :path, :resource_name, :html]

    collection = collect(items: @notes, fields: fields)

    render json: collection
  end

  def editor
    respond_to :json
    Location.read_all
    @note = Note.find_by_resource params[:resource]
    collection = collect items: [@note], fields: [:tags, :path, :date, :filename, :markdown]
    render json: collection.first
  end

  private

  def collect(items:, fields:)
    collection = []
    items.each do |item|
      record = {}
      fields.each do |f|
        record[f] = item.send(f)
      end
      collection.push record
    end
    collection
  end

end
