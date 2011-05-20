class PortalController < ApplicationController

  def index
    @user_session = UserSession.new
  end

  def busca_solidaria
    # o nome da action, tem que conter na mesma pasta, um arquivo com extensao, js.erb, de nome da action.
    # o nome da variavel de instancia, dentro do js.erb, e na action, tem que ser o nome da partial, que
    # tera o nome da classe e ficara dentro da view da classe. ex view/pessoa/_pessoa.html.erb, variavel @pessoas
    # para mostrar, na .js  $("# div a trocar").html("<%= escape_javascript(render(@pessoas)) %>");

    if (params[:query]=="Digite aqui o nome da entidade..." or params[:query].nil? or params[:query].empty?) and
        (params[:filtroNome].nil? or params[:filtroNome].empty?) and
        (params[:filtroUF].nil? or params[:filtroUF].empty?) and
        (params[:filtroCausa].nil? or params[:filtroCausa].empty?)

      @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj')
    else
      #      unless params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
      #        @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj', :conditions => ['entidades.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
      #      end
      @entidades = Entidade.busca(query, uf, causa)
    end
    
    @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj')
    logger.info "\n\n=> meleca 0 #{params[:query]}\n"
    logger.info "\n\n=> meleca 2 #{params[:filtroUF]}\n"
    logger.info "\n\n=> meleca 3 #{params[:filtroCausa]}\n\n"
    
  end

end
