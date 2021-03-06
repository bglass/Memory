class TreeController < ApplicationController
  protect_from_forgery with: :exception

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

end
