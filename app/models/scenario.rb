class Scenario < ActiveRecord::Base
  belongs_to        :owner, :class_name => 'User'
  before_validation :before_validation
  before_save       :before_save_game

  validates_uniqueness_of :guid
  validates_presence_of   :guid
  
  # scenario states
  SCENARIO_STATE_REJECTED       = 0
  SCENARIO_STATE_IN_PROGRESS    = 1
  SCENARIO_STATE_PENDING        = 2
  SCENARIO_STATE_APPROVED       = 3
  
  def before_validation
    generate_guid
  end
  
  def before_save_game
    generate_guid
  end
  
  def generate_guid
    if self.guid.blank?
      self.guid = Guid.generate_20_guid
      Rails.logger.info "game scenario generated [#{self.guid}]"
    end
  end
  
end
