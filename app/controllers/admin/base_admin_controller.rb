class Admin::BaseAdminController < ApplicationController
  
  def require_admin
    if authenticate_user!
      if current_user.email == "steve@orens.com"
        return true
      end
    end
    
    redirect_to welcome_index_path
  end
  
end