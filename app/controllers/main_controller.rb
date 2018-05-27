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
    # Location.read_all
    # @folders  = Folder.top
    # @tags     = Tag.all
    # @notes    = Note.all
    #
    # render "main/grid"

    render "main/elm"
  end

end
