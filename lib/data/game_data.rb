# Game object

class GameData < MarshalData

	SHIP_DATA_DIR				= "ship_data"

	# NATO ship data
	@@nato_ships_hash = nil
	# SOVIET ship data
	@@soviet_ships_hash = nil

	attr_accessor :sunk, :bases, :fleets, :troops, :score, :game_time, :aar

	# 7 September 1986
	GAME_STARTING_TIME = "1986-09-07 00:00:00 UTC"

	def initialize
		@sunk = {}
		@bases = {}
		@fleets = {}
		@troops = {}
		@score = 0
		@game_time = Time.parse GAME_STARTING_TIME
		@aar = []

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

	# have we already loaded ship data?
	def self.ship_data_loaded?
		return false if @@nato_ships_hash.nil? or @@soviet_ships_hash.nil? or @@nato_ships_hash.empty? or @@soviet_ships_hash.empty?
		return true
	end

private
	
	# load the ship data
	def self.load_ships
		unless GameData.ship_data_loaded?
			@@nato_ships_hash = {}
			@@soviet_ships_hash = {}
			nato_file = File.join( Rails.root, SHIP_DATA_DIR, "NATO-ships.csv" )
			soviet_file = File.join( Rails.root, SHIP_DATA_DIR, "SOVIET-ships.csv" )
			Unit.load_ships( nato_file, @@nato_ships_hash )
			Unit.load_ships( soviet_file, @@soviet_ships_hash )
		end
	end
end