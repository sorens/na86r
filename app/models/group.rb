# A Group is a collection of ships (task force), a port or an airfield. 
# Basically, anything that will hold units of some type
#
# TODO: need to add attr fields for aircraft in schema
# TODO: fix the user association
# TODO: conditions?
class Group < ActiveRecord::Base
  has_many :units
  
  after_initialize    :group_init

  # group types
  TYPE_GROUP_PORT                   = "port"
  TYPE_GROUP_AIRFIELD               = "airfield"
  TYPE_GROUP_TASK_FORCE             = "task_force"
  
  # task force missions
  TASK_FORCE_MISSION_COMBAT         = "combat"
  TASK_FORCE_MISSION_BOMBARDMENT    = "bombardment"
  TASK_FORCE_MISSION_TRANSPORT      = "transport"
  TASK_FORCE_MISSION_EVACUATION     = "evacuation"
  TASK_FORCE_MISSION_SUBMARINE      = "submarine"
  TASK_FORCE_MISSION_RETURN         = "return"
  
  # display the name of the group as combination
  # of it's name and mission (if it has a mission)
  def display_name
    unless self.mission.nil?
      "#{self.name.upcase}/#{self.mission.upcase}"
    else
      "#{self.name.upcase}"
    end
  end
  
  private
  
  def group_init
    self.units ||= Array.new
  end
end
