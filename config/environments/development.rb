require File.expand_path( '../../simple_logger.rb', __FILE__ )

NavalConflict::Application.configure do
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
  config.action_controller.perform_caching = false   #set to true and restart server to enable caching
  config.action_controller.page_cache_directory = "#{Rails.public_path}/cache/"

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => '0.0.0.0:3000' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  # turn off color logging messages
  config.colorize_logging = false
  
  config.time_zone = "Pacific Time (US & Canada)"

  # use our simple logger class so we can see a date time stamp for each entry
  # path = File.expand_path( "#{Rails.root}/log/#{Rails.env}.log", __FILE__ )
  path = File.expand_path( "~/logs/#{Rails.application.class.parent_name}_#{Rails.env}.log", __FILE__ )
  logfile = File.open( path, 'a' )
  logfile.sync = true
  Rails.logger = SimpleLogger.new( logfile )
  Rails.logger.debug "Configured to use SimpleLogger"
end

