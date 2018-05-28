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

  def model
    respond_to :json

    Location.read_all

    model = {
      folders:  Folder.top,
      tags:     Tag.all,
      notes:    Note.all,
      book:     "",
      search:   "",
      config:   "",
      errmsg:   "ok"
    }
binding.pry
    render json: model

end
