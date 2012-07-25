class User < ActiveRecord::Base
  has_many :player
  has_many :scenario, :foreign_key => :owner_id
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable,
         :token_authenticatable

  before_save :ensure_authentication_token

  # use ModelUUID to generate the uuid
  include ModelUUID
  
  before_save :ensure_uuid
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessor   :beta_key

  scope :recent, order( "created_at DESC" )
  
  # ensure that we have the uuid
  def ensure_uuid
    if self.uuid.blank?
      self.uuid = generate_uuid( self.email )
    end
  end

end
