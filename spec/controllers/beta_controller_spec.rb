require 'spec_helper'

describe BetaController do
	include Devise::TestHelpers
	let( :email )						{ "email@example.com" }
	let( :password )					{ "abc123" }
	let( :beta_key )					{ FactoryGirl.create :beta_key, :assigned_to => email }
	let( :beta_key_assigned )			{ FactoryGirl.create :beta_key, :assigned }
	let( :beta_key_assigned_disabled )	{ FactoryGirl.create :beta_key, :assigned_disabled }

	render_views
	context ".create" do
		before( :each ) do
			request.env["devise.mapping"] = Devise.mappings[:user]
		end
		context "when beta_key exists and is enabled" do
			it "should create a user account" do
				post :create, :user => { :beta_key => beta_key.key, :email => email, :password => password, :password_confirmation => password }
				user = User.find_by_email email
				user.should be_valid
				user.email.should == email
				key = BetaKey.find_by_key beta_key.key
				key.assigned_to.should == user.email
				key.activated_at.should_not be_nil
			end
			it "should redirect to welcome page" do
				post :create, :user => { :beta_key => beta_key.key, :email => email, :password => password, :password_confirmation => password }
				response.should redirect_to( welcome_index_path )
			end
		end
		context "when key does not match" do
			it "should redirect with message" do
				post :create, :user => { :beta_key => "jjjjj", :email => email, :password => password, :password_confirmation => password }
				response.should redirect_to( new_user_registration_path )
			end
		end
	end
end