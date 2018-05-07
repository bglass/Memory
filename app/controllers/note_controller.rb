class NoteController < ApplicationController
  # protect_from_forgery with: :exception
  # skip_before_action :verify_authenticity_token

  def index
    Location.read_all
    @notes = Note.all
    render "notes/index"
  end

  def view
    Location.read_all
    @note = Note.find(params[:id])
    render "notes/view"
  end

  # def display
  #
  #   selected = params[:selected]
  #   notes = Note.map selected
  #   # note_selection_change(notes)  # update state_display
  #
  #   @note = notes.first   # TBD: display many
  #   render "notes/view"
  # end


end
