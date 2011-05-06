class UsersController < ApplicationController

  access_control do
    allow all,            :to => [:new, :create]
    allow logged_in,      :to => [:show, :edit, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :activate_deactivate ]
  end

  #    logger.info "\n\n=> meleca tipo: #{params[:tipo]}\n"

  def index
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      @user = User.paginate(:page => params[:page], :order => 'nome DESC')
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        @user = User.paginate(:page => params[:page], :order => 'nome DESC',
          :conditions => ['users.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.status = "Ativo" # status A  Ativado
    
    if (( params[:tipo]=='admistrador' and !(administrador?)) or (params[:tipo].nil? or params[:tipo].empty?))
      flag=true
    else

      if @user.save
        #limpa todas as regras antes.
        @user.has_no_roles!
        #cria regras
        @user.has_role! params[:tipo]

        #Cria log de sessão para quando o usuário for criado
        #      Sessao.create(:user => @user, :acao => 'create')
        flash[:notice] = "Cadastrado efetuado com sucesso."
        #redireciono para a tela de acordo com o perfil.
        if administrador?
          redirect_to users_path
        end
        if entidade?
          redirect_to new_entidade_path
        end
        if voluntario?
          redirect_to new_voluntario_path
        end
        if empresa?
          redirect_to new_empresa_path
        end
      else
        flag=true
      end
    end
    if flag==true
      render :action => 'new.html.erb'
    end
  end

  def show
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # Faz a verificação se perfil é administrador
    if administrador?
      @user.has_no_roles!
      @user.has_role! params[:tipo]
    end

    # Verifica se a conta cadatrada do user não é administrador
    if @user.id != 1
      # Altera dados do usuário
      # usuario so pode alterar sua propria conta.
      if @user.id == current_user.id
        if @user.update_attributes(params[:user])
          flash[:notice] = "Dados do usuário alterados com sucesso."
          redirect_to(@user)
        else
          respond_to do |format|
            format.html { render :action => "edit" }
            format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
          end
        end
      else
        render :action => "edit"
      end
    else
      flash[:notice] = "Administrador não pode alterar seu dados."
    end

  end

  def destroy
    @user = User.find(params[:id])
    if @user.id != 1
      @user.destroy
      flash[:notice] = "Usuario excluído com sucesso."
      redirect_to users_url
    else
      flash[:notice] = "Usuário não tem permissão para esta ação."
      redirect_to users_url
    end
  end

  #Função para ativar e desativar usuário
  def activate_deactivate
    @user = User.find(params[:id])
    # Verifica se o usuário não é administrador
    if @user.id != 1
      if @user.status == "Ativo"
        @user.status = "Desativado"
        flash[:notice] = "Usuario desativado com sucesso."
      else
        @user.status = "Ativo"
        flash[:notice] = "Usuario ativado com sucesso."
      end

      if @user.update_attributes(params[:user])
        redirect_to users_url
      else
        flash[:notice] = "Erro na tentiva de alteração."
      end
    else
      flash[:notice] = "Usuário não tem permissão para esta ação."
      redirect_to users_url
    end
  end
end