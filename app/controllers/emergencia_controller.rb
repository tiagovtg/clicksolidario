class EmergenciaController < ApplicationController

  access_control do
    allow :entidade,      :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :valida_emergencia ]
  end

  def index
    @entidade = Entidade.where(" user_id = ?", current_user.id)
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @emergencia = Emergencium.paginate(:page => params[:page], :order => 'validacao, data DESC')
      else
        @emergencia = Emergencium.paginate(:page => params[:page], :order => 'validacao, data DESC', :conditions => [" entidade_id = ?", @entidade[0].id])
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @emergencia = Emergencium.paginate(:page => params[:page], :order => 'validacao, data DESC', :conditions => ['emergencia.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          @emergencia = Emergencium.paginate(:page => params[:page], :order => 'validacao, data DESC', :conditions => [" entidade_id = " + "#{@entidade[0].id} " + ' and emergencia.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  # GET /emergencia/1
  # GET /emergencia/1.xml
  def show
    if administrador?
      @emergencium = Emergencium.find(params[:id])
    else
      @entidade = Entidade.where(" user_id = ?", current_user.id)
      @emergencium = Emergencium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
      render :action => "index" if @emergencium.nil?
    end
  end

  # GET /emergencia/new
  # GET /emergencia/new.xml
  def new
    @emergencium = Emergencium.new
  end

  # GET /emergencia/1/edit
  def edit
    if administrador?
      @emergencium = Emergencium.find(params[:id])
    else
      @entidade = Entidade.where(" user_id = ?", current_user.id)
      @emergencium = Emergencium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
      render :action => "index" if @emergencium.nil?
    end
  end

  # POST /emergencia
  # POST /emergencia.xml
  def create
    @emergencium = Emergencium.new(params[:emergencium])
    @entidade = Entidade.where(" user_id = ?", current_user.id)
    unless @entidade.nil? or @entidade.empty?
      @emergencium.entidade_id = @entidade[0].id
    end

    respond_to do |format|
      if @emergencium.save
        format.html { redirect_to(@emergencium, :notice => 'Emergencia criado(a) com sucesso.') }
        format.xml  { render :xml => @emergencium, :status => :created, :location => @emergencium }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @emergencium.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /emergencia/1
  # PUT /emergencia/1.xml
  def update
    if administrador?
      @emergencium = Emergencium.find(params[:id])

      respond_to do |format|
        if @emergencium.update_attributes(params[:emergencium])
          format.html { redirect_to(@emergencium, :notice => 'Emergencia foi alterado(a) com sucesso.') }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @emergencium.errors, :status => :unprocessable_entity }
        end
      end
    else
      @entidade = Entidade.where(" user_id = ?", current_user.id)
      @emergencium = Emergencium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
      unless @emergencium.nil?
        #       se for feita alguma alteração que nao seje pelo adm, a emergencia volta a ser invalida.
        @emergencium.validacao=false
        respond_to do |format|
          if @emergencium.update_attributes(params[:emergencium])
            format.html { redirect_to(@emergencium, :notice => 'Emergencia foi alterado(a) com sucesso.') }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @emergencium.errors, :status => :unprocessable_entity }
          end
        end
      else
        render :action => "index"
      end
    end
  end

  # DELETE /emergencia/1
  # DELETE /emergencia/1.xml
  def destroy
    if administrador?
      @emergencium = Emergencium.find(params[:id])
      @emergencium.destroy
      respond_to do |format|
        format.html { redirect_to(emergencia_url) }
        format.xml  { head :ok }
      end
    else
      @entidade = Entidade.where(" user_id = ?", current_user.id)
      @emergencium = Emergencium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
      unless @emergencium.nil?
        @emergencium.destroy
        respond_to do |format|
          format.html { redirect_to(emergencia_url) }
          format.xml  { head :ok }
        end
      else
        render :action => "index"
      end
    end
  end

  #Função para validar emergencia
  def valida_emergencia
   @emergencium = Emergencium.find(params[:id])

    if @emergencium.validacao==true
      @emergencium.validacao = false
      flash[:notice] = "Validado com sucesso."
    else
      @emergencium.validacao = true
      flash[:notice] = "Invalidado com sucesso."
    end

    if @emergencium.update_attributes(params[:emergencium])
      redirect_to emergencia_url
    else
      flash[:alert] = "Erro na tentiva de alteração."
    end
  end

  
end
