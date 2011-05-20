class PortalController < ApplicationController

  def index
    @user_session = UserSession.new
  end

  def busca_solidaria

    logger.info "\n\n=> meleca query: #{params[:query]}\n"
    logger.info "\n\n=> meleca uf: #{params[:filtroUF]}\n"
    logger.info "\n\n=> meleca causa: #{params[:filtroCausa]}\n\n"
    

    @entidades = Entidade.busca_solidaria(params[:query], params[:filtroUF], params[:filtroCausa], params[:page])
  end

end
