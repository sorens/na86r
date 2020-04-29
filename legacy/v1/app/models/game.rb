class Game < ActiveRecord::Base
  # todo associate with turn
  # has_many    :turns
  
  # todo add an init method
  # after_initialize    :game_init
  
  # todo game states
  
  # use ModelUUID to generate the uuid
  include ModelUUID
  
  before_validation :ensure_uuid
  before_save       :ensure_uuid

  validates_uniqueness_of :uuid
  validates_presence_of   :uuid
  validate                :valid_scenario?
  
  private
  
  def valid_scenario?
    if self.scenario_id.nil?
      errors.add( :scenario_id, (I18n.t "game.scenario.not_assigned") )
    else
      begin
        Scenario.find(self.scenario_id)
      rescue
        errors.add( :scenario_id, (I18n.t "game.scenario.not_found") )
      end
    end
    Rails.logger.info errors.messages unless errors.messages.empty?
  end
  
  # ensure that we have the uuid
  def ensure_uuid
    if self.uuid.blank?
      self.uuid = generate_uuid
    end
  end
  
end
