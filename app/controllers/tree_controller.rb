class TreeController < ApplicationController
  protect_from_forgery with: :exception

  def data_fields()   [];   end

  def tree
    respond_to :json
    Location.read_all
    # x = get_tree top; binding.pry
    render json: get_tree(top)[:children]
  end


  def get_tree(node)

    record = { text: node.name, id: node.id }
    record[:children] = node.children.map {|c| get_tree(c) }

    data = {}
    data_fields.each do |f|
      data[f] = node.public_send(f)
    end
    record[:data] = data

    record

  end
end
