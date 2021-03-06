# encoding: UTF-8
class EmpresasController < ApplicationController

  access_control do
    allow :entidade,   :to => [:index, :show ]
    allow :empresa,       :to => [:index, :show, :new, :edit, :create, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
  end

  def index
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador? or entidade?
        @empresas = Empresa.paginate(:page => params[:page], :order => 'cnpj')
      else
        @empresas = Empresa.paginate(:page => params[:page], :order => 'cnpj', :conditions => [" user_id = ?", current_user.id], :limit=>1)
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador? or entidade?
          @empresas = Empresa.paginate(:page => params[:page], :order => 'cnpj', :conditions => ['empresas.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          @empresas = Empresa.paginate(:page => params[:page], :order => 'cnpj', :conditions => [" user_id = #{current_user.id}" + ' and empresas.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  # GET /empresas/1
  # GET /empresas/1.xml
  def show
    if administrador? or entidade?
      @empresa = Empresa.find(params[:id])
    else
      @empresa = Empresa.find_by_user_id(current_user.id) rescue nil
      redirect_to empresas_path if @empresa.nil?
    end
  end

  def new
    @empresa = Empresa.all(:conditions => [" user_id = ?", current_user.id])
    # verifica se ja existe uma entidade criada.
    if administrador?
      @empresa = Empresa.new
      3.times {@empresa.telefones.build}
    else
      if @empresa.nil? or @empresa.empty?
        @empresa = Empresa.new
        1.times {@empresa.telefones.build}
      else
        redirect_to :action => "index"
      end
    end
  end

  # GET /empresas/1/edit
  def edit


    if administrador?
      @empresa = Empresa.find(params[:id])
    else
      @empresa = Empresa.find(params[:id],:conditions => [" user_id = ?", current_user.id] ) rescue nil
      render :action => "index" if @empresa.nil?
    end
  end

  # POST /empresas
  # POST /empresas.xml
  def create
    @empresa = Empresa.new(params[:empresa])
    @empresa.user_id = current_user.id
    
    respond_to do |format|
      if @empresa.save
        format.html { redirect_to(@empresa, :notice => 'Empresa criado(a) com sucesso.') }
        format.xml  { render :xml => @empresa, :status => :created, :location => @empresa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empresa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /empresas/1
  # PUT /empresas/1.xml
  def update
    if administrador?
      @empresa = Empresa.find(params[:id])

      respond_to do |format|
        if @empresa.update_attributes(params[:empresa])
          format.html { redirect_to(@empresa, :notice => 'Empresa foi alterado(a) com sucesso.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @empresa.errors, :status => :unprocessable_entity }
        end
      end
    else
      @empresa = Empresa.find(params[:id], :conditions => [" user_id = ?", current_user.id]) rescue nil
      unless @empresa.nil?
        respond_to do |format|
          if @empresa.update_attributes(params[:empresa])
            format.html { redirect_to(@empresa, :notice => 'Emergencium foi alterado(a) com sucesso.') }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @empresa.errors, :status => :unprocessable_entity }
          end
        end
      else
        render :action => "index"
      end
    end
  end

  # DELETE /empresas/1
  # DELETE /empresas/1.xml
  def destroy
    @empresa = Empresa.find(params[:id])
    @empresa.destroy

    respond_to do |format|
      format.html { redirect_to(empresas_url) }
      format.xml  { head :ok }
    end
  end
end
