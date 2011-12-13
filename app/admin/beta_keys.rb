ActiveAdmin.register BetaKey do
  
  filter :key
  filter :assigned_to
  
  scope :all, :default => :true
  scope :disabled
  scope :enabled
  scope :unknown
  scope :activated
  
  index do
    column :assigned_to
    column :activated_at do |a|
      unless a.activated_at.nil?
        a.activated_at.localtime.strftime('%Y-%m-%d %H:%M')
      else
        status_tag( "not set", :warning )
      end
    end
    column :active do |a|
      status_tag( a.state_name, ((a.active == BetaKey::STATE_ENABLED or a.active == BetaKey::STATE_UNKNOWN) ? :warning : (a.active == BetaKey::STATE_DISABLED) ? :error : :ok) )
    end
    column :key
    default_actions
  end
  
  show :title => :assigned_to do |a|
    attributes_table do
      row :id
      row :key
      row :assigned_to
      row :active do
      status_tag( a.state_name, ((a.active == BetaKey::STATE_ENABLED or a.active == BetaKey::STATE_UNKNOWN) ? :warning : (a.active == BetaKey::STATE_DISABLED) ? :error : :ok) )
      end
    end
  end
  
  form do |f|
    if f.object.new_record?
      f.inputs "New Beta Key" do
        f.input :assigned_to
      end
    else
      f.inputs "Edit Beta Key" do
        f.input :assigned_to
        f.input :key
        f.input :active, :as => :select, :collection => BetaKey::STATE, :label_method => lambda { |i| BetaKey::STATE_NAME[i] }
      end
    end
    f.buttons
  end

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
