class PortalController < ApplicationController

  def index
    @user_session = UserSession.new
  end

  def busca_solidaria
#    @entidades = Entidade.all
    @entidades = Entidade.busca_solidaria(params[:query], params[:filtroUF][0], params[:filtroCausa])
  end

end
