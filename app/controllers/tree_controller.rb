class TreeController < ApplicationController
  protect_from_forgery with: :exception

  attr_accessor :data_fields

  # def data_fields()   [];   end

  def tree
    respond_to :json
    Location.read_all
    # puts get_tree(top)[:children]
    render json: get_tree(top)[:children]
  end


  def get_tree(node)

    record = { text: node.name, id: node.id.to_s }
    record[:children] = node.children.map {|c| get_tree(c) }

    data = {}
    data_fields.each do |f|
      data[f] = node.public_send(f) rescue binding.pry
    end
    record[:data] = data
    record

  end


  def model
    respond_to :json
    Location.read_all

    data = {book: "", search: "", config: "", errmsg: "ok"}

    @data_fields   = [:id, :name, :path, :children]
    data[:folders] = get_tree( Folder.top )

    @data_fields   = [:id, :name, :children]
    data[:tags]    = get_tree( Tag.top )

    @data_fields   = [:id, :date, :tags, :path, :resource_name, :name]
    data[:notes ]  = get_tree( Note.top )

    binding.pry
    render json: data
  end





end
