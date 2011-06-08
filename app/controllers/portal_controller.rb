class PortalController < ApplicationController

  def index
    @user_session = UserSession.new
    @noticias = Noticium.where('validacao = true').limit(3).order('updated_at DESC') rescue nil
    @emergencias = Emergencium.where('validacao = true').limit(3).order('updated_at DESC') rescue nil

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end

  end

  def busca_solidaria
    @entidades = Entidade.busca_solidaria(params[:query], params[:filtroUF][0], params[:filtroCausa])
  end

end
