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
  
  # condition
  CONDITION_PASSIVE_EW              = 0
  CONDITION_ACTIVE_EW               = 1
  
  # display the name of the group as combination
  # of it's name and mission (if it has a mission)
  def display_name
    unless self.mission.nil?
      "#{self.name.upcase}/#{self.mission.upcase}"
    else
      "#{self.name.upcase}"
    end
  end
  
  # does this unit include the specified unit
  def include?( unit )
    result = false
    if self.units
      result = true if self.units.include? unit
    end
    result
  end
  
  # set the task force's electronic warfare systems to ACTIVE
  def active_ew()
    return unless self.gtype == TYPE_GROUP_TASK_FORCE
    self.condition = CONDITION_ACTIVE_EW
    self.save
  end
  
  # set the task force's electronic warfare systems to PASSIVE
  def passive_ew()
    return unless self.gtype == TYPE_GROUP_TASK_FORCE
    self.condition = CONDITION_PASSIVE_EW
    self.save
  end
  
  private
  
  def group_init
    self.units ||= Array.new
  end
end
