require 'string'

module NavalConflict
  class ActionReport
    attr_accessor :target, 
    :action, 
    :source, 
    :target_origin,
    :source_origin, 
    :actor, 
    :actor_origin, 
    :method,
    :method_type,
    :message

    def to_s
      self.message
    end
  end
end
