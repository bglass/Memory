class TagController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    Note.read
    @tags = Tag.all
    render "tags/index"
  end

end
