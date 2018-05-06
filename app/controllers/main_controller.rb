class MainController < ActionController::Base
  protect_from_forgery with: :exception

  def view
    Location.read_all
    @folders  = Folder.top
    @tags     = Tag.all
    @notes    = Note.all

    data = {eins: 1, zwei: 2}




    # DisplayChannel.broadcast_to(
    #   'current_user',
    #   title: 'New things!',
    #   body: 'All the news fit to print'
    # )

    render "main/grid"
  end

end
