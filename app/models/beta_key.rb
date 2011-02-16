class BetaKey < ActiveRecord::Base
  
  # states for a beta key
  STATE_DISABLED          = 0
  STATE_ENABLED           = 1
  STATE_USED              = 3
  
  # length of the key to use
  KEY_LENGTH = 20
  
  def self.generate(email)
    key = BetaKey.create( :assigned_to => email, :active => BetaKey::STATE_ENABLED, :key => new_key )
  end
  
  def self.new_key
    UUIDTools::UUID.random_create.hexdigest[0,KEY_LENGTH]
  end
end
