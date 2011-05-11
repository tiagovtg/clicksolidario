ActionMailer::Base.smtp_settings ={
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'www.gmail.com',
  :authentication       => :login,
  :user_name            => 'solidarioclick@gmail.com',
  :password             => 'clicksolidario2011',
  #  :plain, :login or :cram_md5
  :enable_starttls_auto => true  }
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?