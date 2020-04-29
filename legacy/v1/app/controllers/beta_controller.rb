class BetaController < Devise::RegistrationsController

  before_filter   :confirm_beta_key
  before_filter   :confirm_email

  expose( :beta_key ) do
    BetaKey.find_by_assigned_to!( params[:user][:email] ) if params[:user] and params[:user][:email]
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    Rails.logger.error "beta key was not found [#{exception.message}]"
    redirect_to( new_registration_path(resource_name), :alert => "{#{params[:user][:email]}} has not been invited." ) and return
  end

  def create
    if beta_key.key != params[:user][ :beta_key ]
      beta_key.active = BetaKey::STATE_DISABLED
      beta_key.save!
      redirect_to( new_registration_path(resource_name), :alert => "your email does not match your beta key. deactivating your beta key." ) and return
    else
      beta_key.active = BetaKey::STATE_USED
      beta_key.activated_at = DateTime.now
      beta_key.save!
      session["#{resource_name}_return_to"] = welcome_index_path
      super
    end
  end

  private

  def confirm_beta_key
    if params[:user] and params[:user][:beta_key].blank?
      redirect_to( new_registration_path(resource_name), :alert => "please enter a valid beta key." ) and return
    end
  end

  def confirm_email
    if params[:user] and params[:user][:email].blank?
      redirect_to( new_registration_path(resource_name), :alert => "please enter a valid email address." ) and return
    end
  end
end