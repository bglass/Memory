class TreeController < ApplicationController
  protect_from_forgery with: :exception

  attr_accessor :fields

  def initialize
    @fields = [:text, :id]
  end



  def tree
    respond_to :json
    Location.read_all
    render json: get_tree(top)[:children]
  end


  def get_tree(node)

    # binding.pry
    record = {}

    fields.each do |f|
      record[f] = node.public_send(f)
      # binding.pry
    end

    record[:children] = node.children.map {|c| get_tree(c) }

    record

  end
end
