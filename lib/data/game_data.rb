# Game object

class GameData < MarshalData
	attr_accessor :units, :sunk, :bases, :fleets, :troops, :score, :game_time, :aar

	# 7 September 1986
	GAME_STARTING_TIME = 526460400

	def initialize
		@units = {}
		@sunk = {}
		@bases = {}
		@fleets = {}
		@troops = {}
		@score = 0
		@game_time = Time.at GAME_STARTING_TIME
		@aar = []
	end

	# add a unit
	def add_unit( unit )
		@units[Time.now.to_i] = unit
	end
end