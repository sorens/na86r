# Game object
module NA86
    class GameData < MarshalData

        # where is the ship data?
        SHIP_DATA_DIR               = "ship_data"

        # one turn in hours
        ONE_TURN_IN_HOURS           = 12

        # NATO ship data
        @@nato_ships_hash = nil
        # SOVIET ship data
        @@soviet_ships_hash = nil

        attr_accessor :sunk, :bases, :fleets, :troops, :score, :game_start_time, :game_time, :aar
        attr_accessor :nato_ship_data_file, :soviet_ship_data_file
        # 7 September 1986
        GAME_STARTING_TIME = "1986-09-07 00:00:00 UTC"

        def initialize( nato_ship_data_file, soviet_ship_data_file, game_start_time=GAME_STARTING_TIME )
            @nato_ship_data_file = nato_ship_data_file
            @soviet_ship_data_file = soviet_ship_data_file
            NA86.logger().debug("NATO file: #{@nato_ship_data_file}")
            NA86.logger().debug("SOVIET file: #{@soviet_ship_data_file}")
            @sunk = {}
            @bases = {}
            @fleets = {}
            @troops = {}
            @score = 0
            @game_start_time = Time.parse game_start_time
            NA86::logger().debug("game starting time: #{@game_start_time}")
            @game_time = @game_start_time
            @aar = []
            @@header_row = []
            @@nato_ships_hash = {}
            @@soviet_ships_hash = {}
            # load NATO and SOVIET ship data
            GameData.load_ships(@nato_ship_data_file, @soviet_ship_data_file)
        end

        # access to the NATO ships
        def self.nato_ships
            @@nato_ships_hash
        end

        # access to the SOVIET ships
        def self.soviet_ships
            @@soviet_ships_hash
        end

        # access to the header row
        def self.header
            @@header_row
        end

        # have we already loaded ship data?
        def self.ship_data_loaded?
            return false if @@nato_ships_hash.nil? or @@soviet_ships_hash.nil? or @@nato_ships_hash.empty? or @@soviet_ships_hash.empty?
            return true
        end

        # advance X turns
        def advance_turns( turns=1 )
            self.game_time = self.game_time + (ONE_TURN_IN_HOURS * turns) * 3600
            NA86.logger().info "game time: [#{self.game_time}]"
        end

        # advance 1 turn
        def next_turn
            self.advance_turns(1)
        end

        # the number of turns we've completed
        def turn_count
            return ( (self.game_time - self.game_start_time) / 3600 ) / ONE_TURN_IN_HOURS
        end

    private
        
        # load the ship data
        def self.load_ships(nato_file, soviet_file)
            unless GameData.ship_data_loaded?
                NA86::Unit.load_ships( nato_file, @@nato_ships_hash, @@header_row )
                NA86::Unit.load_ships( soviet_file, @@soviet_ships_hash, @@header_row )
            end
        end
    end
end
