class PortalController < ApplicationController

  def index
    @user_session = UserSession.new
  end


  def busca_entidade
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj')
    else
      unless params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj', :conditions => ['entidades.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
      end
    end

    #    respond_to do |format|
    #      format.js {
    #        render :update do |page|
    #          page.replace_html 'ConteudoColunas' , :partial => 'portal/lista_entidades', :locals=> {:entidades => @entidades}
    #        end
    #      }
    #    end

    # http://railscasts.com/episodes/205-unobtrusive-javascript
    #    render :update do |page|
    #      page.insert_html :ConteudoColunas, :partial=> 'portal/lista_entidades',
    #        :locals=> {:entidades => @entidades}
    #
    #      page.replace_html 'ConteudoColunas', :partial=> 'portal/lista_entidades',
    #        :locals=> {:entidades => @entidades}
    #    end
    #    $("#products").html("<%= escape_javascript(render(@products)) %>");
  end

  def busca_perfil
    
  end

  def busca_solidaria
    # o nome da action, tem que conter na mesma pasta, um arquivo com extensao, js.erb
    # o nome da variavel de instancia, dentro do js.erb, e na action, tem que ser o nome da partial
    # de preferencia no mesmo local.
    # nao precisa ter o render @variavel em lugar nenhum.
    # basta $("# div a trocar").html


    #    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
    #      @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj')
    #    else
    #      unless params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
    #        @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj', :conditions => ['entidades.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
    #      end
    #    end
    @lista_entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj')
#    if @entidades.nil? or @entidades.empty?
#      render :nothing=> true
#    end
  end

end
