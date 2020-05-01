require 'naval_conflict/model_uuid'
require 'naval_conflict/core/resolution'
require 'naval_conflict/core/choose_unit'
require 'naval_conflict/core/combat'
require 'naval_conflict/core/combat/hit_one'
require 'naval_conflict/core/combat/intercept_one'
require 'naval_conflict/core/combat/jam_one'
require 'naval_conflict/core/combat/miss_one'
require 'naval_conflict/core/combat/normal'
require 'naval_conflict/data/marshal_data'
require 'naval_conflict/data/game_data'
require 'naval_conflict/data/game_unit'
require 'naval_conflict/data/group'
require 'naval_conflict/data/ordnance'
require 'naval_conflict/data/pipeline'
require 'naval_conflict/data/salvo'
require 'naval_conflict/data/unit'
require 'naval_conflict/data/weapon_mount'
require 'naval_conflict/exceptions'
require 'naval_conflict/guid'
require 'logger'

module NavalConflict
    attr :_logger
    def NavalConflict.logger()
        if @_logger.nil?
            @_logger = Logger.new("log/naval_conflict.log")
            @_logger.level = Logger::INFO
        end
        @_logger
    end

    def NavalConflict.logger_level(level=Logger::INFO)
        @_logger.level = level unless @_logger.nil?
    end
end