class DevelopmentMailInterceptor
  def self.delivering_email(message=@@delivery_interceptors)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "tiagovtg@gmail.com"
  end
end