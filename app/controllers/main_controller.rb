class MainController < ApplicationController
  protect_from_forgery with: :exception

  def view
    Location.read_all
    @folders  = Folder.top
    @tags     = Tag.all
    @notes    = Note.all

    render "main/grid"
  end

  def elm

    render "main/elm"
  end



  def subtree(node, fields)
    record = {children: node.children.map {|c| subtree(c, fields) } }
    fields.each do |f|
      record[f] = node.public_send(f) rescue binding.pry
    end
    record[:id] = record[:id].to_s
    record
  end


  def model
    respond_to :json
    Location.read_all

    data = {book: "", search: "", config: "", errmsg: "Model download ok"}

    data[:folder]  = subtree( Folder.top, [:id, :name, :path])
    data[:tag]     = subtree( Tag.top,    [:id, :name] )
    data[:note]    = subtree( Note.top,
            [:id, :date, :tags, :path, :resource_name, :name] )
# binding.pry
    render json: data
  end








end
