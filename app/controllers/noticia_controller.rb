class NoticiaController < ApplicationController

  access_control do
    allow :entidade,      :to => [:index, :show, :new, :edit, :create, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
  end

  def index
    @entidade = Entidade.where(" user_id = ?", current_user.id)
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @noticia = Noticium.all
      else
        @noticia = Noticium.all(:conditions => [" entidade_id = ?", @entidade[0].id])
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @noticia = Noticium.all(:conditions => ['noticia.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          @noticia = Noticium.all(:conditions => [" entidade_id = " + "#{@entidade[0].id} " + ' and noticia.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  # GET /noticia/1
  # GET /noticia/1.xml
  def show
    @noticium = Noticium.find(params[:id])
  end

  # GET /noticia/new
  # GET /noticia/new.xml
  def new
    @noticium = Noticium.new
  end

  # GET /noticia/1/edit
  def edit
    @noticium = Noticium.find(params[:id])
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
        format.html { redirect_to(@noticium, :notice => 'Noticium was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /noticia/1
  # PUT /noticia/1.xml
  def update
    @noticium = Noticium.find(params[:id])

    respond_to do |format|
      if @noticium.update_attributes(params[:noticium])
        format.html { redirect_to(@noticium, :notice => 'Noticium was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /noticia/1
  # DELETE /noticia/1.xml
  def destroy
    @noticium = Noticium.find(params[:id])
    @noticium.destroy

    redirect_to(noticia_url)
  end
end
