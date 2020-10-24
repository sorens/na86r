# ordnance manages the shootable weapons
module NA86
    class Ordnance

        # weapon types
        WEAPON_LIGHT_GUN                = "AA"
        WEAPON_CL_MAIN_GUN              = "CL"
        WEAPON_BB_MAIN_GUN              = "MG"
        WEAPON_TORPEDO                  = "TORP"
        WEAPON_BOMB                     = "BOMB"
        WEAPON_SAM                      = "SAM"
        WEAPON_ASM                      = "ASM"
        WEAPON_SSM                      = "SSM"
        WEAPON_ASW                      = "ASW"
        WEAPON_AST                      = "AST"
        WEAPON_AAM                      = "AAM"

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

        # ordnance ASW
        TYPE_ASROC                      = "ASROC"
        TYPE_SUBROC                     = "SUBROC"
        TYPE_IKARA                      = "IKARA"
        TYPE_FRAS_1                     = "FRAS"
        TYPE_SS_N_14                    = "SSN14"
        TYPE_SS_N_16                    = "SSN16"

        WEAPONS_ASW = [
            TYPE_ASROC,
            TYPE_SUBROC,
            TYPE_IKARA,
            TYPE_FRAS_1,
            TYPE_SS_N_14,
            TYPE_SS_N_16
        ]

        # ordnance AST
        TYPE_MK48_TORPEDO               = "MK48"
        TYPE_TIGERFISH_TORPEDO          = "TIGER"
        TYPE_533MM_TORPEDO              = "533"
        TYPE_400MM_TORPEDO              = "400"
        TYPE_MK46_TORPEDO               = "MK46"

        WEAPONS_AST = [
            TYPE_MK48_TORPEDO,
            TYPE_TIGERFISH_TORPEDO,
            TYPE_533MM_TORPEDO,
            TYPE_400MM_TORPEDO,
            TYPE_MK46_TORPEDO
        ]

        # ordnance ASM
        TYPE_HARPOON_ASM                = "HASM"
        TYPE_WALLEYE                    = "WALL"
        TYPE_AS_6                       = "AS6"
        TYPE_AS_7                       = "AS7"

        WEAPONS_ASM = [
            TYPE_HARPOON_ASM,
            TYPE_WALLEYE,
            TYPE_AS_6,
            TYPE_AS_7
        ]

        # ordnance SSM
        TYPE_HARPOON_SSM                = "HSSM"
        TYPE_TOMAHAWK                   = "TOMA"
        TYPE_EXOCET                     = "EXOC"
        TYPE_SS_N_2C                    = "SS2C"
        TYPE_SS_N_3                     = "SSN3"
        TYPE_SS_N_7                     = "SSN7"
        TYPE_SS_N_12                    = "SS12"
        TYPE_SS_N_19                    = "SS19"
        TYPE_SS_N_22                    = "SS22"

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

        # ordnance AAM
        TYPE_PHOENIX                    = "PHOE"
        TYPE_AMRAAM                     = "AMRA"
        TYPE_APEX                       = "APEX"
        TYPE_SIDEWINDER                 = "SIDE"
        TYPE_APHID                      = "APHI"

        WEAPONS_AAM = [
            TYPE_PHOENIX,
            TYPE_AMRAAM,
            TYPE_APEX,
            TYPE_SIDEWINDER,
            TYPE_APHID
        ]

        # ordnance SAM
        TYPE_STANDARD                   = "STAN"
        TYPE_SEADART                    = "SEAD"
        TYPE_SEASLUG                    = "SEAS"
        TYPE_SEA_SPARROW                = "SEAP"
        TYPE_SEACAT                     = "SEAC"
        TYPE_SA_N_1                     = "SAN1"
        TYPE_SA_N_3                     = "SAN3"
        TYPE_SA_N_4                     = "SAN4"
        TYPE_SA_N_6                     = "SAN6"
        TYPE_SA_N_7                     = "SAN7"
        TYPE_SA_N_9                     = "SAN9"

        WEAPONS_SAM = [
            TYPE_STANDARD,
            TYPE_SEADART,
            TYPE_SEASLUG,
            TYPE_SEACAT,
            TYPE_SEA_SPARROW,
            TYPE_SA_N_1,
            TYPE_SA_N_3,
            TYPE_SA_N_6,
            TYPE_SA_N_7,
            TYPE_SA_N_9
        ]

        WEAPONS_ALL = WEAPONS_ASW + WEAPONS_AST + WEAPONS_ASM + WEAPONS_SSM + WEAPONS_AAM + WEAPONS_SAM

        # class variable for ordnance info
        @@ordnance = {}

        attr_accessor :ordnance_type, :ordnance_class, :range, :damage, :accuracy, :salvo, :surface_skimming

        # setup each ordnance type
        # type => ordnance_type, ordnance_class range, damage, accuracy, salvo, surface_skimming
        def Ordnance.setup
            # ASW
            Ordnance.setup_ordnance( TYPE_ASROC, WEAPON_ASW, 20, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_SUBROC, WEAPON_ASW, 55, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_IKARA, WEAPON_ASW, 20, 1, 3, 1, false )
            Ordnance.setup_ordnance( TYPE_FRAS_1, WEAPON_ASW, 25, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_SS_N_14, WEAPON_ASW, 50, 1, 3, 1, false )
            Ordnance.setup_ordnance( TYPE_SS_N_16, WEAPON_ASW, 75, 1, 4, 1, false )

            # AST
            Ordnance.setup_ordnance( TYPE_MK48_TORPEDO, WEAPON_AST, 50, 1, 5, 1, false )
            Ordnance.setup_ordnance( TYPE_TIGERFISH_TORPEDO, WEAPON_AST, 40, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_533MM_TORPEDO, WEAPON_AST, 20, 1, 3, 1, false )
            Ordnance.setup_ordnance( TYPE_400MM_TORPEDO, WEAPON_AST, 7, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_MK46_TORPEDO, WEAPON_AST, 10, 1, 4, 1, false )

            # ASM
            Ordnance.setup_ordnance( TYPE_HARPOON_ASM, WEAPON_ASM, 110, 4, 9, 1, true )
            Ordnance.setup_ordnance( TYPE_WALLEYE, WEAPON_ASM, 50, 12, 7, 1, false )
            Ordnance.setup_ordnance( TYPE_AS_6, WEAPON_ASM, 300, 15, 5, 1, true )
            Ordnance.setup_ordnance( TYPE_AS_7, WEAPON_ASM, 10, 7, 4, 7, false )

            # SSM
            Ordnance.setup_ordnance( TYPE_HARPOON_SSM, WEAPON_SSM, 110, 4, 9, 1, true )
            Ordnance.setup_ordnance( TYPE_TOMAHAWK, WEAPON_SSM, 500, 7, 9, 1, true )
            Ordnance.setup_ordnance( TYPE_EXOCET, WEAPON_SSM, 70, 7, 9, 1, true )
            Ordnance.setup_ordnance( TYPE_SS_N_2C, WEAPON_SSM, 50, 5, 5, 1, false )
            Ordnance.setup_ordnance( TYPE_SS_N_3, WEAPON_SSM, 450, 12, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_SS_N_7, WEAPON_SSM, 60, 9, 7, 1, true )
            Ordnance.setup_ordnance( TYPE_SS_N_12, WEAPON_SSM, 500, 9, 6, 1, false )
            Ordnance.setup_ordnance( TYPE_SS_N_19, WEAPON_SSM, 500, 8, 7, 1, false )
            Ordnance.setup_ordnance( TYPE_SS_N_22, WEAPON_SSM, 120, 6, 7, 1, false )

            # AAM
            Ordnance.setup_ordnance( TYPE_PHOENIX, WEAPON_AAM, 300, 1, 4, 3, false )
            Ordnance.setup_ordnance( TYPE_AMRAAM, WEAPON_AAM, 150, 1, 4, 2, false )
            Ordnance.setup_ordnance( TYPE_APEX, WEAPON_AAM, 150, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_SIDEWINDER, WEAPON_AAM, 10, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_APHID, WEAPON_AAM, 10, 1, 4, 1, false )

            # SAM
            Ordnance.setup_ordnance( TYPE_STANDARD, WEAPON_SAM, 50, 1, 4, 4, false )
            Ordnance.setup_ordnance( TYPE_SEADART, WEAPON_SAM, 50, 1, 4, 2, false )
            Ordnance.setup_ordnance( TYPE_SEASLUG, WEAPON_SAM, 30, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_SEACAT, WEAPON_SAM, 5, 1, 1, 1, false )
            Ordnance.setup_ordnance( TYPE_SEA_SPARROW, WEAPON_SAM, 10, 1, 1, 1, false )
            Ordnance.setup_ordnance( TYPE_SA_N_1, WEAPON_SAM, 30, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_SA_N_3, WEAPON_SAM, 40, 1, 4, 2, false )
            Ordnance.setup_ordnance( TYPE_SA_N_4, WEAPON_SAM, 5, 1, 4, 1, false )
            Ordnance.setup_ordnance( TYPE_SA_N_6, WEAPON_SAM, 80, 1, 4, 3, false )
            Ordnance.setup_ordnance( TYPE_SA_N_7, WEAPON_SAM, 25, 1, 4, 4, false )
            Ordnance.setup_ordnance( TYPE_SA_N_9, WEAPON_SAM, 5, 1, 4, 1, false )
        end

        # return the hash for a particular weapon
        def Ordnance.system( type )
            raise Exceptions::WeaponSystemInvalid unless WEAPONS_ALL.include? type
            return @@ordnance[type]
        end

        private

        def initialize( ordnance_type, ordnance_class, range, damage, accuracy, salvo, surface_skimming=false )
            super()
            @ordnance_type = ordnance_type
            @ordnance_class = ordnance_class
            @range = range
            @damage = damage
            @accuracy = accuracy
            @salvo = salvo
            @surface_skimming = surface_skimming        
        end

        def Ordnance.setup_ordnance( ordnance_type, ordnance_class, range, damage, accuracy, salvo, surface_skimming=false )
            @@ordnance[ordnance_type] = Ordnance.new( ordnance_type, ordnance_class, range, damage, accuracy, salvo, surface_skimming )
        end
    end
end
