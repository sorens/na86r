# Ordance manages the shootable weapons

class Ordance

	# weapon types
	WEAPON_LIGHT_GUN				= "AA"
	WEAPON_CL_MAIN_GUN				= "CL"
	WEAPON_BB_MAIN_GUN				= "MG"
	WEAPON_TORPEDO					= "TORP"
	WEAPON_BOMB						= "BOMB"
	WEAPON_SAM						= "SAM"
	WEAPON_ASM						= "ASM"
	WEAPON_SSM						= "SSM"
	WEAPON_ASW						= "ASW"
	WEAPON_AST						= "AST"
	WEAPON_AAM						= "AAM"

	WEAPON_SYSTEMS = [
		WEAPON_LIGHT_GUN,
		WEAPON_CL_MAIN_GUN,
		WEAPON_BB_MAIN_GUN,
		WEAPON_TORPEDO,
		WEAPON_BOMB,
		WEAPON_SAM,
		WEAPON_ASM,
		WEAPON_SSM,
		WEAPON_ASW,
		WEAPON_AST,
		WEAPON_AAM
	]

	# ordance ASW
	TYPE_ASROC						= "ASROC"
	TYPE_SUBROC						= "SUBROC"
	TYPE_IKARA						= "IKARA"
	TYPE_FRAS_1						= "FRAS"
	TYPE_SS_N_14					= "SSN14"
	TYPE_SS_N_16					= "SSN16"

	WEAPONS_ASW = [
		TYPE_ASROC,
		TYPE_SUBROC,
		TYPE_IKARA,
		TYPE_FRAS_1,
		TYPE_SS_N_14,
		TYPE_SS_N_16
	]

	# ordance AST
	TYPE_MK48_TORPEDO				= "MK48"
	TYPE_TIGERFISH_TORPEDO			= "TIGER"
	TYPE_533MM_TORPEDO				= "533"
	TYPE_400MM_TORPEDO				= "400"
	TYPE_MK46_TORPEDO				= "MK46"

	WEAPONS_AST = [
		TYPE_MK48_TORPEDO,
		TYPE_TIGERFISH_TORPEDO,
		TYPE_533MM_TORPEDO,
		TYPE_400MM_TORPEDO,
		TYPE_MK46_TORPEDO
	]

	# ordance ASM
	TYPE_HARPOON_ASM				= "HASM"
	TYPE_WALLEYE					= "WALL"
	TYPE_AS_6						= "AS6"
	TYPE_AS_7						= "AS7"

	WEAPONS_ASM = [
		TYPE_HARPOON_ASM,
		TYPE_WALLEYE,
		TYPE_AS_6,
		TYPE_AS_7
	]

	# ordance SSM
	TYPE_HARPOON_SSM				= "HSSM"
	TYPE_TOMAHAWK					= "TOMA"
	TYPE_EXOCET						= "EXOC"
	TYPE_SS_N_2C					= "SS2C"
	TYPE_SS_N_3						= "SSN3"
	TYPE_SS_N_7						= "SSN7"
	TYPE_SS_N_12					= "SS12"
	TYPE_SS_N_19					= "SS19"
	TYPE_SS_N_22					= "SS22"

	WEAPONS_SSM = [
		TYPE_HARPOON_SSM,
		TYPE_TOMAHAWK,
		TYPE_EXOCET,
		TYPE_SS_N_2C,
		TYPE_SS_N_3,
		TYPE_SS_N_7,
		TYPE_SS_N_12,
		TYPE_SS_N_19,
		TYPE_SS_N_22
	]

	# ordance AAM
	TYPE_PHOENIX					= "PHOE"
	TYPE_AMRAAM						= "AMRA"
	TYPE_APEX						= "APEX"
	TYPE_SIDEWINDER					= "SIDE"
	TYPE_APHID						= "APHI"

	WEAPONS_AAM = [
		TYPE_PHOENIX,
		TYPE_AMRAAM,
		TYPE_APEX,
		TYPE_SIDEWINDER,
		TYPE_APHID
	]

	# ordance SAM
	TYPE_STANDARD					= "STAN"
	TYPE_SEADART					= "SEAD"
	TYPE_SEASLUG					= "SEAS"
	TYPE_SEA_SPARROW				= "SEAP"
	TYPE_SA_N_1						= "SAN1"
	TYPE_SA_N_3						= "SAN3"
	TYPE_SA_N_4						= "SAN4"
	TYPE_SA_N_6						= "SAN6"
	TYPE_SA_N_7						= "SAN7"
	TYPE_SA_N_9						= "SAN9"

	WEAPONS_SAM = [
		TYPE_STANDARD,
		TYPE_SEADART,
		TYPE_SEASLUG,
		TYPE_SEA_SPARROW,
		TYPE_SA_N_1,
		TYPE_SA_N_3,
		TYPE_SA_N_6,
		TYPE_SA_N_7,
		TYPE_SA_N_9
	]

	WEAPONS_ALL = WEAPONS_ASW + WEAPONS_AST + WEAPONS_ASM + WEAPONS_SSM + WEAPONS_AAM + WEAPONS_SAM

	# class variable for ordance info
	@@ordance = {}

	attr_accessor :ordance_type, :ordance_class, :range, :damage, :accuracy, :salvo, :surface_skimming

	# setup each ordance type
	# type => ordance_type, ordance_class range, damage, accuracy, salvo, surface_skimming
	def Ordance.setup
		# ASW
		Ordance.setup_ordance( TYPE_ASROC, WEAPON_ASW, 20, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_SUBROC, WEAPON_ASW, 55, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_IKARA, WEAPON_ASW, 20, 1, 3, 1, false )
		Ordance.setup_ordance( TYPE_FRAS_1, WEAPON_ASW, 25, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_SS_N_14, WEAPON_ASW, 50, 1, 3, 1, false )
		Ordance.setup_ordance( TYPE_SS_N_16, WEAPON_ASW, 75, 1, 4, 1, false )

		# AST
		Ordance.setup_ordance( TYPE_MK48_TORPEDO, WEAPON_AST, 50, 1, 5, 1, false )
		Ordance.setup_ordance( TYPE_TIGERFISH_TORPEDO, WEAPON_AST, 40, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_533MM_TORPEDO, WEAPON_AST, 20, 1, 3, 1, false )
		Ordance.setup_ordance( TYPE_400MM_TORPEDO, WEAPON_AST, 7, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_MK46_TORPEDO, WEAPON_AST, 10, 1, 4, 1, false )

		# ASM
		Ordance.setup_ordance( TYPE_HARPOON_ASM, WEAPON_ASM, 110, 4, 9, 1, true )
		Ordance.setup_ordance( TYPE_WALLEYE, WEAPON_ASM, 50, 12, 7, 1, false )
		Ordance.setup_ordance( TYPE_AS_6, WEAPON_ASM, 300, 15, 5, 1, true )
		Ordance.setup_ordance( TYPE_AS_7, WEAPON_ASM, 10, 7, 4, 7, false )

		# SSM
		Ordance.setup_ordance( TYPE_HARPOON_SSM, WEAPON_SSM, 110, 4, 9, 1, true )
		Ordance.setup_ordance( TYPE_TOMAHAWK, WEAPON_SSM, 500, 7, 9, 1, true )
		Ordance.setup_ordance( TYPE_EXOCET, WEAPON_SSM, 70, 7, 9, 1, true )
		Ordance.setup_ordance( TYPE_SS_N_2C, WEAPON_SSM, 50, 5, 5, 1, false )
		Ordance.setup_ordance( TYPE_SS_N_3, WEAPON_SSM, 450, 12, 4, 1, false )
		Ordance.setup_ordance( TYPE_SS_N_7, WEAPON_SSM, 60, 9, 7, 1, true )
		Ordance.setup_ordance( TYPE_SS_N_12, WEAPON_SSM, 500, 9, 6, 1, false )
		Ordance.setup_ordance( TYPE_SS_N_19, WEAPON_SSM, 500, 8, 7, 1, false )
		Ordance.setup_ordance( TYPE_SS_N_22, WEAPON_SSM, 120, 6, 7, 1, false )

		# AAM
		Ordance.setup_ordance( TYPE_PHOENIX, WEAPON_AAM, 300, 1, 4, 3, false )
		Ordance.setup_ordance( TYPE_AMRAAM, WEAPON_AAM, 150, 1, 4, 2, false )
		Ordance.setup_ordance( TYPE_APEX, WEAPON_AAM, 150, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_SIDEWINDER, WEAPON_AAM, 10, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_APHID, WEAPON_AAM, 10, 1, 4, 1, false )

		# SAM
		Ordance.setup_ordance( TYPE_STANDARD, WEAPON_SAM, 50, 1, 4, 4, false )
		Ordance.setup_ordance( TYPE_SEADART, WEAPON_SAM, 50, 1, 4, 2, false )
		Ordance.setup_ordance( TYPE_SEASLUG, WEAPON_SAM, 30, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_SEA_SPARROW, WEAPON_SAM, 10, 1, 1, 1, false )
		Ordance.setup_ordance( TYPE_SA_N_1, WEAPON_SAM, 30, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_SA_N_3, WEAPON_SAM, 40, 1, 4, 2, false )
		Ordance.setup_ordance( TYPE_SA_N_4, WEAPON_SAM, 5, 1, 4, 1, false )
		Ordance.setup_ordance( TYPE_SA_N_6, WEAPON_SAM, 80, 1, 4, 3, false )
		Ordance.setup_ordance( TYPE_SA_N_7, WEAPON_SAM, 25, 1, 4, 4, false )
		Ordance.setup_ordance( TYPE_SA_N_9, WEAPON_SAM, 5, 1, 4, 1, false )
	end

	# return the hash for a particular weapon
	def Ordance.system( type )
		raise Exceptions::WeaponSystemInvalid unless WEAPONS_ALL.include? type
		return @@ordance[type]
	end

	private

	def initialize( ordance_type, ordance_class, range, damage, accuracy, salvo, surface_skimming=false )
		@ordance_type = ordance_type
		@ordance_class = ordance_class
		@range = range
		@damage = damage
		@accuracy = accuracy
		@salvo = salvo
		@surface_skimming = surface_skimming		
	end

	def Ordance.setup_ordance( ordance_type, ordance_class, range, damage, accuracy, salvo, surface_skimming=false )
		@@ordance[ordance_type] = Ordance.new( ordance_type, ordance_class, range, damage, accuracy, salvo, surface_skimming )
	end
end

