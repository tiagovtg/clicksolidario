class EntidadesController < ApplicationController

  access_control do
    allow :entidade,      :to => [:index, :show, :new, :edit, :create, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
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

  # GET /entidades/1
  # GET /entidades/1.xml
  def show
    if administrador?
      @entidade = Entidade.find(params[:id])
    else
      @entidade = Entidade.find(params[:id], :conditions => [" user_id = ?", current_user.id]) rescue nil
      render :action => "index" if @entidade.nil?
    end
  end

  def new
    
    # verifica se ja existe uma entidade criada.
    if administrador?
      @entidade = Entidade.new
    else
      @entidades = Entidade.all(:conditions => [" user_id = ?", current_user.id])
      if @entidades.nil? or @entidades.empty?
        @entidade = Entidade.new
      else
        redirect_to :action => "index"
      end
    end
    2.times {@entidade.telefones.build}
    1.times {@entidade.conta.build}
  end

  # GET /entidades/1/edit
  def edit
    if administrador?
      @entidade = Entidade.find(params[:id])
    else
      @entidade = Entidade.find(params[:id], :conditions => [" user_id = ?", current_user.id]) rescue nil
      render :action => "index" if @entidade.nil?
    end
  end

  # POST /entidades
  # POST /entidades.xml
  def create
    @entidade = Entidade.new(params[:entidade])
    @entidade.user_id = current_user.id

    respond_to do |format|
      if @entidade.save
        format.html { redirect_to(@entidade, :notice => 'Entidade was successfully created.') }
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
    if administrador?
      @entidade = Entidade.find(params[:id])

      respond_to do |format|
        if @entidade.update_attributes(params[:entidade])
          format.html { redirect_to(@entidade, :notice => 'Entidade was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @entidade.errors, :status => :unprocessable_entity }
        end
      end
    else
      @entidade = Entidade.find(params[:id], :conditions => [" user_id = ?", current_user.id]) rescue nil
      unless @entidade.nil?
        respond_to do |format|
          if @entidade.update_attributes(params[:entidade])
            format.html { redirect_to(@entidade, :notice => 'Emergencium was successfully updated.') }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @entidade.errors, :status => :unprocessable_entity }
          end
        end
      else
        render :action => "index"
      end
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
end



def show
  load_empresa
  render :action => "index" if @empresa.nil?
end

def new
  load_empresa
  # seu código aqui...
end

def create
  load_empresa
  # seu código aqui...
end

private
def load_empresa
  if administrador?
    @empresa = Empresa.find(params[:id])
  else
    @empresa = Empresa.where(" user_id = ?", current_user.id) rescue nil
  end
end