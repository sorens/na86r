ActiveAdmin.register AdminUser do
  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end
  
  controller do
    def create
      email = params[:admin_user][:email]
      if AdminUser.find_by_email( email ).nil?
        au = AdminUser.new
        au.email = email
        au.save
        message = "Admin User [#{au.email}] was created."
      else
        message = "There is already an Admin User for [#{email}]"
      end
      redirect_to admin_admin_users_path, :notice => message
    end
  end
end
