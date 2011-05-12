class NewsletterMailer < ActionMailer::Base
  #http://api.rubyonrails.org/classes/ActionMailer/Base.html#method-i-mail
  default :from => "tiagovtg@gmail.com"
  
  def envia_email(user)
    @user = user
    @url  = "localhost:3000"
    #    attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{user.nome} <#{user.email}>", :subject => "Registered")
  end
end
