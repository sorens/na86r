class Game < ActiveRecord::Base
  # todo associate with turn
  # has_many    :turns
  
  # todo add an init method
  # after_initialize    :game_init
  
  # todo game states
  
  before_validation :before_validation
  before_save       :before_save_game

  validates_uniqueness_of :guid
  validates_presence_of   :guid
  validate                :valid_scenario?
  
  # guid length
  GUID_LENGTH = 20
  
  private
  
  def valid_scenario?
    if self.scenario_id.nil?
      errors.add( :scenario_id, (I18n.t "game.scenario.not_assigned") )
    else
      begin
        unless self.scenario
          errors.add( :scenario_id, (I18n.t "game.scenario.not_found") )
        end
      rescue
        errors.add( :scenario_id, (I18n.t "game.scenario.not_found") )
      end
    end
    Rails.logger.info errors if errors 
  end
  
  def before_validation
    generate_guid
  end
  
  def before_save_game
    generate_guid
  end
  
  def generate_guid
    if self.guid.blank?
      self.guid = UUIDTools::UUID.random_create.hexdigest[ 0,GUID_LENGTH ]
      Rails.logger.info "game guid generated [#{self.guid}]"
    end
  end
  
end
