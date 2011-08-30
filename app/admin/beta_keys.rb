ActiveAdmin.register BetaKey do
  index do
    column :assigned_to
    column :activated_at
    column :active do |post|
      case post.active
        when BetaKey::STATE_DISABLED
          "disabled"
        when BetaKey::STATE_ENABLED
          "enabled"
        when BetaKey::STATE_USED
          "activated"
        end
    end
    column :key
    default_actions
  end
  
  # member_action :new, :method => :post do
  #   beta_key = BetaKey.new
  #   render :partial => "new", :locals => { :beta_key => beta_key }
  # end
  # 
  # if new_record?
  #   form :partial => "new"
  # else
  #   form :partial => "edit"
  # end
  
  # form do |f|
  #   if f.object.new_record?
  #     f.inputs "New Beta Key" do
  #       f.input :assigned_to
  #     end
  #     f.buttons
  #   end
  # end

  # 
  # form do |f|
  #   f.inputs "Edit Beta Key" do
  #     f.input :assigned_to
  #   end
  #   f.buttons
  # end
  
  controller do
    def create
      email = params[:beta_key][:assigned_to]
      if BetaKey.find_by_assigned_to( email ).nil?
        beta_key = BetaKey.generate( email )
        message = "Beta Key [#{beta_key.key}] for [#{beta_key.assigned_to}] was created."
      else
        message = "There is already a Beta Key for [#{email}]"
      end
      redirect_to admin_beta_keys_path, :notice => message
    end
  end
end
