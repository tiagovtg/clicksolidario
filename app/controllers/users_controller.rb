class UsersController < ApplicationController

  access_control do
    allow anonymous,      :to => [:new, :create]
    allow :entidade,      :to => [:index, :show, :edit, :update]
    allow :voluntario,    :to => [:index, :show, :edit, :update]
    allow :empresa,       :to => [:index, :show, :edit, :update]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :activate_deactivate ]
  end

  #    logger.info "\n\n=> meleca tipo: #{params[:tipo]}\n"

  def index
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      if administrador?
        @user = User.paginate(:page => params[:page], :order => 'nome')
      else
        @user = User.paginate(:page => params[:page], :order => 'nome', :conditions => [" id = ?", current_user.id], :limit=>1)
      end
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        if administrador?
          @user = User.paginate(:page => params[:page], :order => 'nome',
            :conditions => ['users.email'+' LIKE ?', "%#{params[:query]}%"])
        else
          @user = User.paginate(:page => params[:page], :order => 'nome',
            :conditions => [" id = #{current_user.id}" + ' and users.email'+' LIKE ?', "%#{params[:query]}%"])
        end
      end
    end
  end

  def new
    @user = User.new
    render :layout=> 'portal'
  end

  def create
    @user = User.new(params[:user])
    @user.status = "Ativo" # status A  Ativado
    
    if (( params[:tipo]=='administrador' and !(administrador?)) or (params[:tipo].nil? or params[:tipo].empty?))
      flag=true
    else

      if @user.save
        #cria um newsletter caso o user tenha aceitado a opção.
        if @user.newsletter
          #          Salvando email para newsletter
          @email = Newsletter.new(:nome=>@user.nome, :email=>@user.email)
          @email.save
          #          mandando email via web
          #          CountMail.enviar_email(@email)
        end

        #limpa todas as regras antes.
        @user.has_no_roles!
        #cria regras
        @user.has_role! params[:tipo]

        #Cria log de sessão para quando o usuário for criado
        #      Sessao.create(:user => @user, :acao => 'create')
        flash[:notice] = "Cadastrado efetuado com sucesso."
        #redireciono para a tela de acordo com o perfil.
        if params[:tipo]=='administrador'
          redirect_to users_path
        end
        if params[:tipo]=='entidade'
          redirect_to new_entidade_path
        end
        if params[:tipo]=='voluntario'
          redirect_to new_voluntario_path
        end
        if params[:tipo]=='empresa'
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
    load_user
    render :action => "index" if @user.nil?
  end

  def edit
    load_user
    render :action => "index" if @user.nil?
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
      if @user.id == current_user.id or administrador?
        if @user.update_attributes(params[:user])
          #se o usuario nao quiser mais o newsletter....
          unless @user.newsletter
            if @email = Newsletter.find_by_email(@user.email) rescue nil              
              unless @email.nil?
                @email.destroy
              end
            end
          else
            #usuario quer incluir de novo o email.
            if @user.newsletter
              @email = Newsletter.new(:nome=>@user.nome, :email=>@user.email)
              @email.save
            end
          end
          flash[:notice] = "Dados do usuário alterados com sucesso."
          redirect_to users_url
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
      #ao deletar o usuario, deleta tambem, seu email
      if @email = Newsletter.find_by_email(@user.email) rescue nil
        unless @email.nil?
          @email.destroy
        end
      end
      @user.destroy
      flash[:notice] = "Usuario excluído com sucesso."
      redirect_to users_url
    else
      flash[:notice] = "Usuário não tem permissão para esta ação."
      redirect_to users_url
    end
  end

  #Função para ativar e desativar usuário
  def valida_usuario
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

  private
  def load_user
    if administrador?
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id) rescue nil
    end
  end
end