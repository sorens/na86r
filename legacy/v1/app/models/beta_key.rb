class BetaKey < ActiveRecord::Base
  
  # states for a beta key
  STATE_DISABLED          = 0
  STATE_ENABLED           = 1
  STATE_UNKNOWN           = 2
  STATE_USED              = 3
  STATE = [STATE_DISABLED, STATE_ENABLED, STATE_UNKNOWN, STATE_USED]
  STATE_NAME = ["disabled", "enabled", "unknown", "activated"]
  
  # length of the key to use
  KEY_LENGTH = 20
  
  scope :recent, order( "created_at DESC" )
  scope :disabled, where( 'active = 0' )
  scope :enabled, where( 'active = 1' )
  scope :unknown, where( 'active = 2' )
  scope :activated, where( 'active = 3' )

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
  
  def state_name
    STATE_NAME[self.active]
  end
end
