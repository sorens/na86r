# weapon mount tracks the loadout and salvos available for a given weapon system on a given unit

class WeaponMount

	# fire max salvo size
	MAX_SALVO_SIZE			= -1

	attr_accessor :ordance, :max_salvo, :max_loadout, :remaining_salvo, :remaining, :ordance_fired

	# fire a salvo
	def fire_salvo( salvo_size=MAX_SALVO_SIZE )
		salvo_size = self.max_salvo if salvo_size == MAX_SALVO_SIZE
		raise Exceptions::WeaponMountSalvoLimit if salvo_size > self.max_salvo
		use_ordance( salvo_size )
	end

	# does this weapon mount have ordance remaining to fire in this salvo?
	def is_salvo?
		self.remaining_salvo > 0
	end

	# reset the salvo stats for this turn
	def reset_salvo
		self.remaining_salvo = max_salvo
	end

	# refit means fill our loadouts to max
	def refit
		self.ordance_fired = 0
		self.remaining = self.max_loadout
		self.remaining_salvo = self.max_salvo
	end

	private

	def use_ordance( amount )
		# sanity check
		raise Exceptions::WeaponMountOrdanceDepleted if self.remaining == 0
		raise Exceptions::WeaponMountSalvoDepleted if self.remaining_salvo == 0
		raise Exceptions::WeaponMountSalvoLimit if self.remaining_salvo - amount < 0
		raise Exceptions::WeaponMountLimit if self.remaining - amount < 0
		self.remaining = self.remaining - amount
		self.remaining_salvo = self.remaining_salvo - amount
		self.ordance_fired = self.ordance_fired + amount
	end

	def initialize( ordance_type, max_salvo=nil, max_loadout )
		@ordance = Ordance.system( ordance_type )
		@max_salvo = max_salvo unless max_salvo.nil?
		@max_salvo = @ordance.salvo if max_salvo.nil?
		@max_loadout = max_loadout
		@remaining_salvo = @max_salvo
		@remaining = @max_loadout
		@ordance_fired = 0
	end
end