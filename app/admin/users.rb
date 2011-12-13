ActiveAdmin.register User do
  filter :email
  
  index do
    column :email
    column :current_sign_in_at do |a|
      a.current_sign_in_at.localtime.strftime('%Y-%m-%d %H:%M')
    end
    column :last_sign_in_at do |a|
      a.last_sign_in_at.localtime.strftime('%Y-%m-%d %H:%M')
    end
    column :sign_in_count
    default_actions
  end
  
  show :title => :email do |a|
    attributes_table do
      row :id
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
    end
  end
  
  form do |f|
    f.inputs "User Details" do
      f.input :email
    end
    f.buttons
  end

  controller do
    def create
      email = params[:user][:email]
      if User.find_by_email( email ).nil?
        a = User.new
        a.email = email
        a.save
        message = "User [#{a.email}] was created."
      else
        message = "User [#{email}] already exists."
      end
      redirect_to admin_users_path, :notice => message
    end
  end
end
