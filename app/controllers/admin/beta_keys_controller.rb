class Admin::BetaKeysController < Admin::BaseAdminController
  respond_to :html
  before_filter :require_admin
  
  expose( :beta_keys )  { BetaKey.order( 'activated_at DESC') }
  expose( :beta_key )
  
  def index
    respond_with( beta_keys )
  end
  
  def show
    respond_with( beta_key )
  end
  
  def edit
    respond_with( beta_key )
  end
  
  def new
    respond_with( beta_key )
  end
  
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
  
  def destroy
    beta_key.destroy
    redirect_to admin_beta_keys_path, :notice => "Beta Key [#{beta_key.key}] for [#{beta_key.assigned_to}] was destroyed."
  end
  
end