# encoding: UTF-8
class EntidadesController < ApplicationController

  access_control do
    allow :empresa,       :to => [:index, :show ]
    allow :voluntario,    :to => [:index, :show ]
    allow :entidade,      :to => [:index, :show, :new, :edit, :create, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :impressao_entidade ]
  end
  
  def index
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj')
      else
        @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj', :conditions => [" user_id = ?", current_user.id], :limit=>1)
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj', :conditions => ['entidades.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          @entidades = Entidade.paginate(:page => params[:page], :order => 'cnpj', :conditions => [" user_id = #{current_user.id}" + ' and entidades.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  def show
    load_entidade
    render  :layout=> 'portal', :action => "index" if @entidade.nil?
  end

  def new
    # verifica se ja existe uma entidade criada.
    @entidades = Entidade.all(:conditions => [" user_id = ?", current_user.id])
    if @entidades.nil? or @entidades.empty?
      @entidade = Entidade.new
      1.times {@entidade.telefones.build}
      1.times {@entidade.conta.build}
      #      render :layout=> 'portal'
    else
      redirect_to :action => "index"
    end
  end

  def edit
    load_entidade
    render :action => "index" if @entidade.nil?
  end

  # POST /entidades
  # POST /entidades.xml
  def create
    @entidade = Entidade.new(params[:entidade])
    @entidade.user_id = current_user.id

    respond_to do |format|
      if @entidade.save
        format.html { redirect_to(@entidade, :notice => 'Entidade criado(a) com sucesso.') }
        format.xml  { render :xml => @entidade, :status => :created, :location => @entidade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entidades/1
  # PUT /entidades/1.xml
  def update
    load_entidade
    unless @entidade.nil?
      respond_to do |format|
        if @entidade.update_attributes(params[:entidade])
          format.html { redirect_to(@entidade, :notice => 'Emergencium foi alterado(a) com sucesso.') }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @entidade.errors, :status => :unprocessable_entity }
        end
      end
    else
      render :action => "index"
    end
  end

  # DELETE /entidades/1
  # DELETE /entidades/1.xml
  def destroy
    @entidade = Entidade.find(params[:id])
    @entidade.destroy

    respond_to do |format|
      format.html { redirect_to(entidades_url) }
      format.xml  { head :ok }
    end
  end


  def impressao_entidade
    @conteudo = $conteudo
    render :layout=> 'impressao'
    #        respond_to do |format|
    #      format.html
    #      format.pdf {
    #        html = render_to_string(:layout => 'impressao' ),
    #        kit = PDFKit.new(html, :quality => 25),
    #        kit.stylesheets << "#{Rails.root}/public/stylesheets/impressao.css",
    #        send_data(kit.to_pdf, :filename => 'impressao.pdf', :type => "pdf")
    #      }
    #    end
  end

  def pegaCep()
    obter_cep(cep)
  end

  #DAQUI PRA BAIXO É PRIVADO, NAO ADICIONE MAIS NADA, A NAO SER QUE NAO QUEIRA VE-LO NA TELA.
  private
  def load_entidade
    if administrador? or empresa? or voluntario?
      @entidade = Entidade.find(params[:id])
    else
      @entidade = Entidade.find(params[:id], :conditions => [" user_id = ?", current_user.id]) rescue nil
    end
  end
  
end