class NewsletterMailer < ActionMailer::Base
  #http://api.rubyonrails.org/classes/ActionMailer/Base.html#method-i-mail
  default :from => "solidarioclick@gmail.com"

  #envia email.
  def envia_email(nome, email, subject, body)
#    @user = user
#    @url  = "localhost:3000"
    #    attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{nome} <#{email}>", :subject => subject, :body=> body)
  end

#  def recupera_sehna(user)
##    @user = user
##    @url  = "localhost:3000"
#    mail(:to => "#{user.nome} <#{user.email}>", :subject => "Recuperação de senha do Click Solidario.",
#      :body=>"Por motivos de segurança, usuario(#{user.email}), não temos acesso a sua senha, então foi resetado e gerado uma senha temporaria: 1234")
#
#    @user = User.find(user.id)
#    if @user.update_attributes(params[:user])
#      redirect_to root
#    end
#  end
end
