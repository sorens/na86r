class BetaController < Devise::RegistrationsController
  def create
    Rails.logger.info "user [#{params[:user][:email]}]" unless params[:user][:email].blank?
    
    if params[:user][:beta_key].blank?
      redirect_to( new_registration_path(resource_name), :alert => "invalid beta key." )
    elsif params[:user][:email].blank?
      redirect_to( new_registration_path(resource_name), :alert => "please enter a valid email address." )
    else
      bk = BetaKey.find_beta_key( params[:user][:email] )
      if bk.nil? or bk.key.nil?
        redirect_to( new_registration_path(resource_name), :alert => "{#{params[:user][:email]}} has not been invited." )
      else
        if bk.key != params[:user][ :beta_key ]
          bk.active = BetaKey::STATE_DISABLED
          bk.save!
          redirect_to( new_registration_path(resource_name), :alert => "your email does not match your beta key. deactivating your beta key." )
        else
          super
          bk.active = BetaKey::STATE_USED
          bk.activated_at = DateTime.now
          bk.save!
          redirect_to welcome_index_path, :notice => "welcome."
        end
      end
    end
    
  end
end
