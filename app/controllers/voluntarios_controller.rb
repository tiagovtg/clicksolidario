class VoluntariosController < ApplicationController

  access_control do
    allow :voluntarios,   :to => [:index, :show, :new, :edit, :create, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
  end
  
  def index
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @voluntarios = Voluntario.all
      else
        @voluntarios = Voluntario.all(:conditions => [" user_id = ?", current_user.id], :limit=>1)
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @voluntarios = Voluntario.all(:conditions => ['voluntarios.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          @voluntarios = Voluntario.all(:conditions => [" user_id = #{current_user.id}" + ' and voluntarios.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  def show
    @voluntario = Voluntario.find(params[:id])
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
    @voluntario = Voluntario.find(params[:id])
  end

  def create
    @voluntario = Voluntario.new(params[:voluntario])
    @voluntario.user_id = current_user.id

    respond_to do |format|
      if @voluntario.save
        format.html { redirect_to(@voluntario, :notice => 'Voluntario was successfully created.') }
        format.xml  { render :xml => @voluntario, :status => :created, :location => @voluntario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @voluntario.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @voluntario = Voluntario.find(params[:id])

    respond_to do |format|
      if @voluntario.update_attributes(params[:voluntario])
        format.html { redirect_to(@voluntario, :notice => 'Voluntario was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @voluntario.errors, :status => :unprocessable_entity }
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
