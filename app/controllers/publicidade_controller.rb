class PublicidadeController < ApplicationController
   layout 'portal'
   
  def index
    @user_session = UserSession.new
  end
  
end