class TreeController < ApplicationController
  protect_from_forgery with: :exception


  def tree
    respond_to :json
    Location.read_all
    render json: get_tree(top)[:children]
  end


  def get_tree(node)
    {
      text:       node.name,
      id:         node.id,
      children:   node.children.map {|c| get_tree(c) }
    }
  end
end
