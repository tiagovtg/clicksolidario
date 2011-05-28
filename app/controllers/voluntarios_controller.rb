class VoluntariosController < ApplicationController

  access_control do
    allow :voluntario,   :to => [:index, :show, :new, :edit, :create, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
  end
  
  def index
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @voluntarios = Voluntario.paginate(:page => params[:page], :order => 'cpf')
      else
        @voluntarios = Voluntario.paginate(:page => params[:page], :order => 'cpf', :conditions => [" user_id = ?", current_user.id], :limit=>1)
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @voluntarios = Voluntario.paginate(:page => params[:page], :order => 'cpf',
            :conditions => ['voluntarios.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          @voluntarios = Voluntario.paginate(:page => params[:page], :order => 'cpf',
            :conditions => [" user_id = #{current_user.id}" + ' and voluntarios.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  def show
    if administrador?
      @voluntario = Voluntario.find(params[:id])
    else
      @voluntario = Voluntario.find(params[:id], :conditions => [" user_id = ?", current_user.id]) rescue nil
      render :action => "index" if @voluntario.nil?
    end
  end

  def new
    @voluntario = Voluntario.all(:conditions => [" user_id = ?", current_user.id])
    # verifica se ja existe uma entidade criada.
    if administrador?
      @voluntario = Voluntario.new
      3.times {@voluntario.telefones.build}
    else
      if @empresa.nil? or @empresa.empty?
        @voluntario = Voluntario.new
        3.times {@voluntario.telefones.build}
      else
        redirect_to :action => "index"
      end
    end
  end

  def edit
    if administrador?
      @voluntario = Voluntario.find(params[:id])
    else
      @voluntario = Voluntario.find(params[:id],:conditions => [" user_id = ?", current_user.id] ) rescue nil
      render :action => "index" if @voluntario.nil?
    end
  end

  def create
    @voluntario = Voluntario.new(params[:voluntario])
    @voluntario.user_id = current_user.id

    respond_to do |format|
      if @voluntario.save
        format.html { redirect_to(@voluntario, :notice => 'Voluntario criado(a) com sucesso.') }
        format.xml  { render :xml => @voluntario, :status => :created, :location => @voluntario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @voluntario.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    if administrador?
      @voluntario = Voluntario.find(params[:id])

      respond_to do |format|
        if @voluntario.update_attributes(params[:voluntario])
          format.html { redirect_to(@voluntario, :notice => 'Voluntario foi alterado(a) com sucesso.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @voluntario.errors, :status => :unprocessable_entity }
        end
      end
    else
      @voluntario = Voluntario.find(params[:id],:conditions => [" user_id = ?", current_user.id] ) rescue nil
      unless @voluntario.nil?
        respond_to do |format|
          if @voluntario.update_attributes(params[:voluntario])
            format.html { redirect_to(@voluntario, :notice => 'Voluntario foi alterado(a) com sucesso.') }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @voluntario.errors, :status => :unprocessable_entity }
          end
        end
      else
        render :action => "index"
      end
    end
  end

  def destroy
    @voluntario = Voluntario.find(params[:id])
    @voluntario.destroy

    respond_to do |format|
      format.html { redirect_to(voluntarios_url) }
      format.xml  { head :ok }
    end
  end
end
