require File.expand_path( '../../simple_logger.rb', __FILE__ )

NavalConflict::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => '0.0.0.0:3000' }

  # turn off color logging messages
  config.colorize_logging = false
  
  # use our simple logger class so we can see a date time stamp for each entry
  # path = File.expand_path( "#{Rails.root}/log/#{Rails.env}.log", __FILE__ )
  path = File.expand_path( "~/logs/#{Rails.application.class.parent_name}_#{Rails.env}.log", __FILE__ )
  logfile = File.open( path, 'a' )
  logfile.sync = true
  Rails.logger = SimpleLogger.new( logfile )
  Rails.logger.debug "Configured to use SimpleLogger"
end
