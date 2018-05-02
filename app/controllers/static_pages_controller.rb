 class StaticPagesController < ActionController::Base
   def show
     render "static_pages/" + params[:page]
   end

  end
