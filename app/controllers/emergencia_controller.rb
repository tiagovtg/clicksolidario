class EmergenciaController < ApplicationController

  access_control do
    allow :entidade,      :to => [:index, :show, :new, :edit, :create, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
  end

  def index
    @entidade = Entidade.where(" user_id = ?", current_user.id)
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @emergencia = Emergencium.paginate(:page => params[:page], :order => 'data DESC')
      else
        @emergencia = Emergencium.paginate(:page => params[:page], :order => 'data DESC', :conditions => [" entidade_id = ?", @entidade[0].id])
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @emergencia = Emergencium.paginate(:conditions => ['emergencia.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          @emergencia = Emergencium.paginate(:conditions => [" entidade_id = " + "#{@entidade[0].id} " + ' and emergencia.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  # GET /emergencia/1
  # GET /emergencia/1.xml
  def show
    @entidade = Entidade.where(" user_id = ?", current_user.id)
    @emergencium = Emergencium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
    render :action => "index" if @emergencium.nil?
  end

  # GET /emergencia/new
  # GET /emergencia/new.xml
  def new
    @emergencium = Emergencium.new
  end

  # GET /emergencia/1/edit
  def edit

    @entidade = Entidade.where(" user_id = ?", current_user.id)
    logger.info "\n\n=> meleca tipo: #{@entidade[0].user_id}\n"
#    if @entidade.user == current_user or administrador?
#      @emergencium = Emergencium.find(params[:id], :conditions => [" entidade_id = ?", @entidade[0].id]) rescue nil
#    else
#      render :action => "index"
#    end
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
        format.html { redirect_to(@emergencium, :notice => 'Emergencium was successfully created.') }
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
    @emergencium = Emergencium.find(params[:id])

    respond_to do |format|
      if @emergencium.update_attributes(params[:emergencium])
        format.html { redirect_to(@emergencium, :notice => 'Emergencium was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @emergencium.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /emergencia/1
  # DELETE /emergencia/1.xml
  def destroy
    @emergencium = Emergencium.find(params[:id])
    @emergencium.destroy

    respond_to do |format|
      format.html { redirect_to(emergencia_url) }
      format.xml  { head :ok }
    end
  end

  
end
