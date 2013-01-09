source 'http://rubygems.org'

######################################################
################ C O M M O N  G E M S ################
######################################################
gem   'rails',          '3.2.11'
gem   'pg'
gem   'devise'
gem   'ruby-uuid'
gem   'uuidtools'
gem   'decent_exposure'
gem   'simple_form'
gem   'activeadmin'
gem   'meta_search',    '>= 1.1.0.pre'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',           "~> 3.2.3"
  gem 'coffee-rails',         "~> 3.2.1"
  gem 'uglifier',             "~> 1.0.3"
  gem 'less-rails-bootstrap', "~> 1.4.0"
end

# used ncurses in an attempt to make
# a command-line version
# preserving gem here
#gem   'ncurses'

gem 'jquery-rails'

######################################################
############## D E V E L O P M E N T #################
#################### T E S T #########################
######################################################
# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem "rspec-rails"
  gem "capybara"
  gem "factory_girl_rails", "~> 4.0"
end

######################################################
############## D E V E L O P M E N T #################
######################################################
group :development do
end

######################################################
#################### T E S T #########################
######################################################
group :test do
	gem 'spork-rails'
end

######################################################
################## S T A G I N G #####################
######################################################
group :staging do
end

######################################################
################ P R O D U C T I O N #################
######################################################
group :production do
end