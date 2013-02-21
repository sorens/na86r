# Game object

class GameData < MarshalData

	# where is the ship data?
	SHIP_DATA_DIR				= "ship_data"

	# one turn in hours
	ONE_TURN_IN_HOURS			= 12

	# NATO ship data
	@@nato_ships_hash = nil
	# SOVIET ship data
	@@soviet_ships_hash = nil

	attr_accessor :sunk, :bases, :fleets, :troops, :score, :game_start_time, :game_time, :aar

	# 7 September 1986
	GAME_STARTING_TIME = "1986-09-07 00:00:00 UTC"

	def initialize( game_start_time=GAME_STARTING_TIME )
		@sunk = {}
		@bases = {}
		@fleets = {}
		@troops = {}
		@score = 0
		@game_start_time = Time.parse game_start_time
		@game_time = @game_start_time
		@aar = []
		@@header_row = []
		@@nato_ships_hash = {}
		@@soviet_ships_hash = {}
		# load NATO and SOVIET ship data
		GameData.load_ships
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
		self.game_time = self.game_time + (ONE_TURN_IN_HOURS * turns).hours
		Rails.logger.info "game time: [#{self.game_time}]"
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
	def self.load_ships
		unless GameData.ship_data_loaded?
			nato_file = File.join( Rails.root, SHIP_DATA_DIR, "NATO-ships.csv" )
			soviet_file = File.join( Rails.root, SHIP_DATA_DIR, "SOVIET-ships.csv" )
			Unit.load_ships( nato_file, @@nato_ships_hash, @@header_row )
			Unit.load_ships( soviet_file, @@soviet_ships_hash, @@header_row )
		end
	end
end