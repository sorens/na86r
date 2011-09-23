source 'http://rubygems.org'

######################################################
################ C O M M O N  G E M S ################
######################################################
gem   'rails',      '3.1.0'
gem   'heroku'
gem   'devise'
#gem   'omniauth',   '>=0.2.6'
gem   'uuidtools'
#gem   'ncurses'
gem   'decent_exposure'
gem   'simple_form'
gem   'activeadmin'
gem   'sass-rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Rails 3.1 stuff...
# Gems used only for assets and not required
# in production environments by default.
group :assets do
#  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

######################################################
############## D E V E L O P M E N T #################
#################### T E S T #########################
######################################################
# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  # gem 'webrat'
  gem "rspec-rails", "~> 2.4"
  gem "cucumber"
  gem "cucumber-rails"
  gem "capybara"
  gem "factory_girl"
  gem "launchy"
  gem "vcr"
  gem "fakeweb"
end

######################################################
############## D E V E L O P M E N T #################
######################################################

######################################################
#################### T E S T #########################
######################################################
group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

######################################################
################## S T A G I N G #####################
######################################################

######################################################
################ P R O D U C T I O N #################
######################################################
