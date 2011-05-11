class NewsletterMailer < ActionMailer::Base
  #  access_control do
  #    allow :administrador
  #  end
  
  default :from => "solidarioclick@gmail.com"

  def envia_email(user)
    logger.info "\n\n=> meleca tipo: #{user.nome}\n"

    @user = user
    @url  = "localhost:3000"
    #    attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{user.nome} <#{user.email}>", :subject => "Registered")
    #          :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"])
  end

end
