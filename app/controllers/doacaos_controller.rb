class DoacaosController < ApplicationController

  access_control do
    allow :entidade,      :to => [:index, :show ]
    allow :empresa,       :to => [:index, :show, :new, :edit, :create, :update]
    allow :voluntario,    :to => [:index, :show, :new, :edit, :create, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
  end

  def index
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC')
      else
        @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC', :conditions => [" user_id = ?", current_user.id], :limit=>1)
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC', :conditions => ['doacaos.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC', :conditions => [" user_id = #{current_user.id}" + ' and doacaos.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  def show
    @doacao = Doacao.find(params[:id])
  end

  def new
    @doacao = Doacao.new
  end

  def edit
    @doacao = Doacao.find(params[:id])
  end

  def create
    @doacao = Doacao.new(params[:doacao])
#    @doacao.voluntario_id
#    @doacao.empresa_id
#    @doacao.entidade_id

#       @voluntario.user_id = current_user.id

    respond_to do |format|
      if @doacao.save
        format.html { redirect_to(@doacao, :notice => 'Doacao was successfully created.') }
        format.xml  { render :xml => @doacao, :status => :created, :location => @doacao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @doacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @doacao = Doacao.find(params[:id])

    respond_to do |format|
      if @doacao.update_attributes(params[:doacao])
        format.html { redirect_to(@doacao, :notice => 'Doacao was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @doacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @doacao = Doacao.find(params[:id])
    @doacao.destroy

    respond_to do |format|
      format.html { redirect_to(doacaos_url) }
      format.xml  { head :ok }
    end
  end
end
