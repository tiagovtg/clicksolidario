class NoticiaController < ApplicationController

  access_control do
    allow :entidade,      :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :valida_noticia ]
  end

  def index
    @entidade = Entidade.where(" user_id = ?", current_user.id)
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @noticia = Noticium.paginate(:page => params[:page], :order => 'validacao, data DESC')
      else
        @noticia = Noticium.paginate(:page => params[:page], :order => 'validacao, data DESC', :conditions => [" entidade_id = ?", @entidade[0].id])
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @noticia = Noticium.paginate(:page => params[:page], :order => 'validacao, data DESC', :conditions => ['noticia.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          @noticia = Noticium.paginate(:page => params[:page], :order => 'validacao, data DESC', :conditions => [" entidade_id = " + "#{@entidade[0].id} " + ' and noticia.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  # GET /noticia/1
  # GET /noticia/1.xml
  def show
    if administrador?
      @noticium = Noticium.find(params[:id])
    else
      @entidade = Entidade.where(" user_id = ?", current_user.id)
      @noticium = Noticium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
      render :action => "index" if @noticium.nil?
    end
  end

  # GET /noticia/new
  # GET /noticia/new.xml
  def new
    @noticium = Noticium.new
  end

  # GET /noticia/1/edit
  def edit
    if administrador?
      @noticium = Noticium.find(params[:id])
    else
      @entidade = Entidade.where(" user_id = ?", current_user.id)
      @noticium = Noticium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
      render :action => "index" if @noticium.nil?
    end
  end

  # POST /noticia
  # POST /noticia.xml
  def create
    @noticium = Noticium.new(params[:noticium])
    @entidade = Entidade.where(" user_id = ?", current_user.id)
    unless @entidade.nil? or @entidade.empty?
      @noticium.entidade_id = @entidade[0].id
    end

    respond_to do |format|
      if @noticium.save
        flash[:notice] = 'Noticia criado(a) com sucesso.'
        format.html { redirect_to(@noticium) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /noticia/1
  # PUT /noticia/1.xml
  def update
    if administrador?
      @noticium = Noticium.find(params[:id])
      respond_to do |format|
        if @noticium.update_attributes(params[:noticium])
          flash[:notice] ='Noticia alterado(a) com sucesso.'
          format.html { redirect_to(@noticium) }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @noticium.errors, :status => :unprocessable_entity }
        end
      end
    else
      @entidade = Entidade.where(" user_id = ?", current_user.id)
      @noticium = Noticium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
      unless @noticium.nil?
        #        se for feita alguma alteração no noticia que nao seje pelo adm, ela volta a ser invalida.
        @noticium.validacao=false
        respond_to do |format|
          if @noticium.update_attributes(params[:noticium])
            flash[:notice] ='Noticia alterado(a) com sucesso.'
            format.html { redirect_to(@noticium) }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @noticium.errors, :status => :unprocessable_entity }
          end
        end
      else
        render :action => "index"
      end
    end
  end

  # DELETE /noticia/1
  # DELETE /noticia/1.xml
  def destroy
    if administrador?
      @noticium = Noticium.find(params[:id])
      @noticium.destroy
      respond_to do |format|
        format.html { redirect_to(noticia_url) }
        format.xml  { head :ok }
      end
    else
      @entidade = Entidade.where(" user_id = ?", current_user.id)
      @noticium = Noticium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
      unless @noticium.nil?
        @noticium.destroy
        respond_to do |format|
          format.html { redirect_to(noticia_url) }
          format.xml  { head :ok }
        end
      else
        render :action => "index"
      end
    end
  end

  #Função para validar noticia
  def valida_noticia
    @noticium = Noticium.find(params[:id])

    if @noticium.validacao==true
      @noticium.validacao = false
      flash[:notice] = "Validado com sucesso."
    else
      @noticium.validacao = true
      flash[:notice] = "Invalidado com sucesso."
    end

    if @noticium.update_attributes(params[:noticium])
      redirect_to noticia_url
    else
      flash[:alert] = "Erro na tentiva de alteração."
    end
  end


end
