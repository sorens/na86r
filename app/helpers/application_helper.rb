module ApplicationHelper
  
  def is_beta_user?
    if current_user and BetaKey.does_user_have_beta_key( current_user.email )
      return true
    end
    
    return false
  end
  
  def resource_name
    :user
  end
  
  def resource
    @resource ||= User.new
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
