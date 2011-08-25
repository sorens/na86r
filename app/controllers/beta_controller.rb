class BetaController < Devise::RegistrationsController
  def create
    Rails.logger.info "user [#{params[:user][:email]}]" unless params[:user][:email].blank?
    
    if params[:user][:beta_key].blank?
      redirect_to( new_registration_path(resource_name), :alert => "invalid beta key." )
    elsif params[:user][:email].blank?
      redirect_to( new_registration_path(resource_name), :alert => "please enter a valid email address." )
    else
      key = BetaKey.find_beta_key( params[:user][:email] )
      if key.nil? or key.key.nil?
        redirect_to( new_registration_path(resource_name), :alert => "{#{params[:user][:email]}} has not been invited." )
      else
        if key.key != params[:user][ :beta_key ]
          redirect_to( new_registration_path(resource_name), :alert => "your email does not match your beta key. deactivating your beta key." )
          key.active = BetaKey::STATE_DISABLED
          key.save!
        else
          super
          key.active = BetaKey::STATE_USED
          key.activated_at = DateTime.now
          key.save!
          flash[ :notice ] = "welcome."
        end
      end
    end
    
  end
end
