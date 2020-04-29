class Scenario < ActiveRecord::Base
  belongs_to        :owner, :class_name => 'User'

  # use ModelUUID to generate the uuid
  include ModelUUID
  
  before_validation :ensure_uuid
  before_save       :ensure_uuid
  validates_uniqueness_of :uuid
  validates_presence_of   :uuid
  
  # scenario states
  SCENARIO_STATE_REJECTED       = 0
  SCENARIO_STATE_IN_PROGRESS    = 1
  SCENARIO_STATE_PENDING        = 2
  SCENARIO_STATE_APPROVED       = 3
  
  # ensure that we have the uuid
  def ensure_uuid
    if self.uuid.blank?
      self.uuid = generate_uuid( self.name )
    end
  end
  
end
