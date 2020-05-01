class Combat::HitOne < NavalConflict::Resolution
	def self.resolve( source, target, salvo )
		target.units[self.which_unit(target.units)].apply_damage( salvo.ordnance.damage )
		salvo.hits(1)
	end
end