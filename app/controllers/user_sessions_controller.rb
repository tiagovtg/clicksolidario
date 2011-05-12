class UserSessionsController < ApplicationController
  #skip_before_filter :require_user, :check_role

  def new
    @user_session = UserSession.new
  end

  #  Método para validação da sessão do usuário
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      if current_user.status == "Desativado"
        @user_session.destroy
        #protegerá contra ataques de fixação de sessão, resetando a sessão.
        reset_session
        #Sessao.create :user => current_user.id, :acao => 'logout'
        flash[:notice] = "Usuário esta desativado, entre em contato com o administrador do sistema."
        redirect_to login_url
      else
        #Cria log de sessão para quando o usuário logar
        #Sessao.create(:user => @user_session.user, :acao => 'login')
        if session[:return_to] && !session[:return_to].include?(url_for(:action => "new"))
          flash[:notice] = "Usuário logado com sucesso."
          redirect_to session[:return_to]
          session[:return_to] = nil
        else
          redirect_to login_url
        end
      end
    else
      render :action => 'new'
    end
  end

  #  Mata a sessão do usuário
  def destroy
    if (@user_session = UserSession.find)
      #Cria log de sessão para quando o usuário deslogar
      #      Sessao.create(:user => @user_session.user, :acao => 'logout')
      @user_session.destroy
      reset_session
      flash[:notice] = "Sessão finalizada."
      redirect_to root_url
    else
      flash[:notice] = "Usuário já esta deslogado."
      redirect_to root_url
    end
  end

end