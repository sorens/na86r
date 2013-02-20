# weapon mount tracks the loadout and salvos available for a given weapon system on a given unit

class WeaponMount

	# fire max salvo size
	MAX_SALVO_SIZE			= -1

	attr_accessor :ordnance, :max_salvo, :max_loadout, :remaining_salvo, :remaining, :ordnance_fired

	# fire a salvo
	def fire_salvo( salvo_size=MAX_SALVO_SIZE )
		salvo_size = self.max_salvo if salvo_size == MAX_SALVO_SIZE
		raise Exceptions::WeaponMountSalvoLimit if salvo_size > self.max_salvo
		use_ordnance( salvo_size )
	end

	# does this weapon mount have ordnance remaining to fire in this salvo?
	def is_salvo?
		self.remaining_salvo > 0
	end

	# reset the salvo stats for this turn
	def reset_salvo
		self.remaining_salvo = max_salvo
	end

	# refit means fill our loadouts to max
	def refit
		self.ordnance_fired = 0
		self.remaining = self.max_loadout
		self.remaining_salvo = self.max_salvo
	end

	# what kind of weapon is this?
	def weapon_class
		return self.ordnance.ordnance_class
	end

	# weapon range
	def weapon_range
		return self.ordnance.range
	end

	private

	def use_ordnance( amount )
		# sanity check
		raise Exceptions::WeaponMountordnanceDepleted if self.remaining == 0
		raise Exceptions::WeaponMountSalvoDepleted if self.remaining_salvo == 0
		raise Exceptions::WeaponMountSalvoLimit if self.remaining_salvo - amount < 0
		raise Exceptions::WeaponMountLimit if self.remaining - amount < 0
		self.remaining = self.remaining - amount
		self.remaining_salvo = self.remaining_salvo - amount
		self.ordnance_fired = self.ordnance_fired + amount
	end

	def initialize( ordnance_type, max_salvo=nil, max_loadout )
		@ordnance = Ordnance.system( ordnance_type )
		@max_salvo = max_salvo unless max_salvo.nil?
		@max_salvo = @ordnance.salvo if max_salvo.nil?
		@max_loadout = max_loadout
		@remaining_salvo = @max_salvo
		@remaining = @max_loadout
		@ordnance_fired = 0
	end
end