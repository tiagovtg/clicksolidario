class PortalController < ApplicationController

  def index
    
  end


  def busca_entidade
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj')
    else
      unless params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj', :conditions => ['entidades.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
      end
    end

    render :update do |page|
      page.replace_html 'lista_entidade', :partial=> 'portal/lista_entidades',
        :locals=> {:entidades => @entidades}
    end
  end

  def busca_perfil
    
  end

end
