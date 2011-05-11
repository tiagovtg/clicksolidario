# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sgss::Application.initialize!

# configurações para email
#config.action_mailer.delivery_method = :sendmail
#config.action_mailer.perform_deliveries = true
#config.action_mailer.raise_delivery_errors = true