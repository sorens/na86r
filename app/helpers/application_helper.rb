module ApplicationHelper
  
  def is_beta_user?
    if current_user and BetaKey.does_user_have_beta_key( current_user.email )
      return true
    end
    
    return false
  end

end
