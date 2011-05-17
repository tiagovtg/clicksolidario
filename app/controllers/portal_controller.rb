class PortalController < ApplicationController

  def busca_entidade
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj')
    else
      unless params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj', :conditions => ['entidades.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
      end
    end
    render :partial=> 'lista_entidades', :locals=> {:entidades => @entidades }
  end

  def busca_perfil
    
  end
  respond_to do |format|
    if @issue.save
      format.js do
        vamos renderizar a parcial com tudo relativo
        @issue = Issue.new
        render :partial => 'issues/issues_operations'
      end
      format.html do
        redirect_to(
          {:controller => :projects, :action => :show, :id => @project.id},
          {:notice => 'issue was successfully created.'}
        )
      end
    else
      format.js {render :partial => 'issues/issues_operations'}
      format.html {render :template => 'projects/show'}
    end
  end
end
