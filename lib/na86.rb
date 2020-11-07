require 'na86/model_uuid'
require 'na86/core/resolution'
require 'na86/core/choose_unit'
require 'na86/core/combat'
require 'na86/core/combat/hit_one'
require 'na86/core/combat/intercept_one'
require 'na86/core/combat/jam_one'
require 'na86/core/combat/miss_one'
require 'na86/core/combat/normal'
require 'na86/data/marshal_data'
require 'na86/data/aircraft'
require 'na86/data/game_data'
require 'na86/data/game_unit'
require 'na86/data/group'
require 'na86/data/ordnance'
require 'na86/data/pipeline'
require 'na86/data/salvo'
require 'na86/data/unit'
require 'na86/data/weapon_mount'
require 'na86/exceptions'
require 'na86/guid'
require 'logger'

module NA86
    attr :_logger
    @@_path = "log/na86.log"

    def NA86.initialize(path="")
        @@_path = path if !path.empty?
    end
    
    def NA86.logger()
        if @_logger.nil?
            @_logger = Logger.new(@@_path)
            @_logger.level = Logger::INFO
        end
        @_logger
    end

    def NA86.logger_level(level=Logger::INFO)
        @_logger.level = level unless @_logger.nil?
    end
end
