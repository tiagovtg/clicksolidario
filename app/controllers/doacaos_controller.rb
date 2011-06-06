class DoacaosController < ApplicationController

  access_control do
    allow :entidade,      :to => [:index, :show ]
    allow :empresa,       :to => [:index, :show, :new, :edit, :create, :update]
    allow :voluntario,    :to => [:index, :show, :new, :edit, :create, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :valida_doacoes ]
  end

  def index
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC')
      else
        if entidade?
          @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC', :conditions => [" entidade_id = ?", entidade_id?], :limit=>1) rescue nil
        else
          @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC', :conditions => [" user_id = ?", current_user.id], :limit=>1) rescue nil
        end
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC', :conditions => ['doacaos.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
        else
          if entidade?
            @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC', :conditions => [" entidade_id = #{entidade_id?}" + ' and doacaos.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
          else
            @doacaos = Doacao.paginate(:page => params[:page], :order => 'data DESC', :conditions => [" user_id = #{current_user.id}" + ' and doacaos.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
          end
        end
      end
    end
  end

  def show
    @doacao = Doacao.find(params[:id])
  end

  def new
    @doacao = Doacao.new
    render :layout=> 'portal'
  end

  def edit
    @doacao = Doacao.find(params[:id])
  end

  def create
    @doacao = Doacao.new(params[:doacao])
    @doacao.user_id= current_user.id

    respond_to do |format|
      if @doacao.save
        format.html { redirect_to(@doacao, :notice => 'Doacao criado(a) com sucesso.') }
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
        format.html { redirect_to(@doacao, :notice => 'Doacao foi alterado(a) com sucesso.') }
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

  #Função para validar doações
  def valida_doacoes
    @doacao = Doacao.find(params[:id])

    if @doacao.valida==true
      @doacao.valida = false
      flash[:notice] = "Validado com sucesso."
    else
      @doacao.valida = true
      flash[:notice] = "Invalidado com sucesso."
    end

    if @doacao.update_attributes(params[:doacao])
      redirect_to doacaos_url
    else
      flash[:alert] = "Erro na tentiva de alteração."
    end
  end

  private
  def entidade_id?
    id = Entidade.where(" user_id = #{current_user.id} ").order('updated_at DESC') rescue nil
    return id[0].id unless id.nil?
  end

end

