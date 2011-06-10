class ApplicationController < ActionController::Base
  protect_from_forgery

  # helper method serve para que vc use seu metodo na aplicação e nas views(global)
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user, :administrador?, :voluntario?, :entidade?, :empresa?, :who?, :versao?

  # Configurando para não colocar passwords nos arquivos de log.
  config.filter_parameters :password, :password_confirmation

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  # verifica se é administrador
  def administrador?
    current_user && current_user.has_role?(:administrador)
  end

  #  verifica se é Voluntario
  def voluntario?
    current_user && current_user.has_role?(:voluntario)
  end

  #  verifica se é entidade
  def entidade?
    current_user && current_user.has_role?(:entidade)
  end

  #  verifica se é entidade
  def empresa?
    current_user && current_user.has_role?(:empresa)
  end
  
  def who?
    if current_user.has_role?(:administrador)
      return "Administrador"
    elsif current_user.has_role?(:voluntario)
      return "Voluntario"
    elsif current_user.has_role?(:entidade)
      return "Entidade"
    elsif current_user.has_role?(:empresa)
      return "Empresa"
    end
  end

  # Se usuario nao tem permissao, redireciona para uma template, se tempo esxpirar, retorna para tela de login.
  rescue_from 'Acl9::AccessDenied', :with => :access_denied
  private
  def access_denied
    if current_user
      #TODO fazer tela de acesso negado.
      render :template => 'generals/denied'
    else
      flash[:notice] = 'Tempo expirou ou você precisa estar logado para esse acesso.'
      session[:return_to] = request.request_uri
      redirect_to login_path
    end
  end


  # mostra versao atual do sistema.
  # TODO colocar saida de versao na tela de sobre e layout
  def versao?
    "Versão 1.0"
  end

end
