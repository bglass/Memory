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

  def lookup(node, field)
    data = { node.id.to_s => node.public_send(field) }
    node.children.each do |c|
      data.merge! lookup(c, field)
    end
    data
  end

  def model
    respond_to :json
    Location.read_all


    folder  = { tree:   subtree( Folder.top, [:id, :name]),
                path:   lookup(  Folder.top, :path)
              }
    tag     = { tree:   subtree( Tag.top,    [:id, :name])
              }
    note    = { tree:   subtree( Note.top,   [:id, :name]),
                path:   lookup(  Note.top, :path)
              }
    link    = { note_folder: Note.note_folder,
                note_tag:    Note.note_tag
              }
binding.pry
    data = {  errmsg:   "Model download ok",
              folder:   folder,
              tag:      tag,
              note:     note,
              link:     link
            }
    render json: data
  end

end
