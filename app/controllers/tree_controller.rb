class TreeController < ApplicationController
  protect_from_forgery with: :exception


  def tree
    respond_to :json
    Location.read_all
    binding.pry
    render json: get_tree(top)
  end


  def get_tree(node)
    if node.children.any?
      node.children.map {|c| get_tree c }
    else
      name_and_id(node)
    end
  end

  def name_and_id(node)
    {name: node.name, id: node.id}
  end

end
