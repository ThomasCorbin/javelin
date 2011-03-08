Javelin::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin


#  puts "in development.rb, $0 is #{$0}"
  if $0 == "script/rails"
    ActiveRecord::Base.logger     = Logger.new(STDOUT)
    ActionController::Base.logger = Logger.new(STDOUT)
    config.logger = Logger.new(STDOUT)
  else
    config.logger = Logger.new( Rails.root.join( "log", Rails.env + ".log" ), 3, 5 * 1024 * 1024 )
  end

  config.log_level = Logger::DEBUG # In any environment initializer, or
#  Rails.logger.level = 0 # at any time
end
