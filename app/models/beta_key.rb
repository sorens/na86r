class BetaKey < ActiveRecord::Base
  
  # states for a beta key
  STATE_DISABLED          = 0
  STATE_ENABLED           = 1
  STATE_USED              = 3
  
  # length of the key to use
  KEY_LENGTH = 20
  
  scope :recent, order( "created_at DESC" )  

  def self.generate( email )
    BetaKey.create( :assigned_to => email, :active => BetaKey::STATE_ENABLED, :key => BetaKey.new_key )
  end
  
  def self.new_key
    UUIDTools::UUID.random_create.hexdigest[ 0,KEY_LENGTH ]
  end
  
  def self.find_beta_key( email )
    users = BetaKey.find_all_by_assigned_to( email )
    if users and 1 == users.length and users.first and BetaKey::STATE_ENABLED == users.first.active
      return users.first
    end
    
    return nil
  end
end
