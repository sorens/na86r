class GameUnit
	# use ModelUUID to generate the uuid
	include ModelUUID

	attr_accessor :uuid

	def initialize
		if @uuid.blank?
			@uuid = generate_uuid( self.to_s )
		end
	end
end