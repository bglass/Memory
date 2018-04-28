class TagController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    Location.read_all
    @tags = Tag.all
    render "tags/index"
  end

end
