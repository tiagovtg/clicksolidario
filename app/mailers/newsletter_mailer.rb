class NewsletterMailer < ActionMailer::Base
  #  access_control do
  #    allow :administrador
  #  end
  
  default :from => "solidarioclick@gmail.com"

  def envia_email(user)
    logger.info "\n\n=> meleca tipo: #{user.nome}\n"

    @user = user
    @url  = "localhost:3000"
    mail( :to => user.email,
      :subject => "Welcome to My Awesome Site")
    #          :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"])
  end
end
