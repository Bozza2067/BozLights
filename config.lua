MuteHornToneSwitcher = true
UsingVanillaSiren = false -- UNUSED AS OF RIGHT NOW
ShowDebugInfo = false

----------------------
-- ENABLED VEHICLES --
----------------------
-- By default, vehicles in the emergency class will have light/siren control features. 
-- This section will let you define vehicles that don't conform to that default.

ModelsWithEquipment = 
{
    "lsiaops1",
    "lsiaops2",
    "lsiaops3",
    "riot3",
}

ModelsWithNoEquipment =
{
    "glpdalamo2"
}

------------------------------------
-- VEHICLES WITH SPECIAL FEATURES --
------------------------------------

-- Vehicles with no third tone: Useful for california-compliant sirens that only have Wail and Yelp.
ModelsWithNoTertiaryTone = 
{
    "bcfdbat",

    "bcsonalamo",
    "bcsospeedo",

    "centurionlspd",

    "cfpdscout",
    "cfpdtorrence",
    "cfpdalamo",

    "dppd",
    "dppdk9",
    "dppdsgt",
    "dppdunmk",
    "dppdcara",
    "dppdcara2",
    "dppdcaraspare",
    "dppdscout",
    "dppdscoutk9",
    "dppdscoutsgt",
    "dppdscoutunmk",

    "glpdalamo",
    "glpdalamo2",
    "glpdbison",
    "glpdbisonum",
    "glpdgresley",
    "glpdgresleyum",
    "glpdscout",
    "glpdstanier",

    "LSFDGRANGER",

    "rhpdfug",
    "rhpdfugumk",
    "rhpdscout",
    "rhpdscoutk9",
    "rhpdscoutslick",
    "rhpdscoutumk",
    "rhpdstanier",

    "sahp",
    "sahp1a",
    "sahp1b",
    "sahp1b2",
    "sahp1b3",
    "sahp1c",
    "sahp1d",
    "sahp1e",
    "sahp2",
    "sahp2a",
    "sahp2b",

    "sadcrnscout",
    "sadcrrumpo",
    "sadcrstanier",
    "sadcrstank9",
    "sadcrtorrence",
    "sadcrtorrslick",
    
    "lsiaops1",
    "lsiaops2",
}

-- Vehicles with a 4th tone activated by a seperate button. Usually a Hi-Lo.
ModelsWithQuarternaryTone = 
{
    -- PolicingMP
    "bcfdbat",
    "bcsonalamo",
    "bcsospeedo",
    "cfpdscout",
    "cfpdtorrence",
    "cfpdalamo",
    "rhpdfug",
    "rhpdSCOUTSLICK",
    "sahp",
    "sahp1a",
    "sahp1b",
    "sahp1b2",
    "sahp1d",
    "sahp1e",
    "sahp2",
    "sahp2a",

    -- New Wave RP
	"LCPD2E",
	"LCPD2F",
	"LCPD3B",
	"LCPD4B",
	"LCPD6A",
	"LCPDT6A",

    -- Vanilla
    "fbi",
    "police3",
    "police",
}

-- Vehicles with dual sirens
ModelsWithAuxiliaryTone = 
{
    "cfpdscout",
    "cfpdtorrence",
    "cfpdalamo",
    "dppd",
    "dppdk9",
    "dppdsgt",
    "dppdunmk",
    "dppdcara",
    "dppdcara2",
    "dppdcaraspare",
    "dppdscout",
    "dppdscoutk9",
    "dppdscoutsgt",
    "dppdscoutunmk",
    "rhpdfug",
    "rhpdfugumk",
    "rhpdscout",
    "rhpdscoutk9",
    "rhpdscoutslick",
    "rhpdstanier",
}

-- Vehicles that use the horn to change tones. Disabled electronic horn. Horn behavior: Regular car horn when lights off, manual tone when lights on, change tone when sirens on.
ModelsWithHornSwitch = 
{   
    "sahp1b3",
    "sahp1c",
    "sahp2b",
}

ModelsWithRumbler =
{
    -- PolicingMP
    "lsiaops1",
    "lsiaops2",

    -- New Wave RP
	"LCPD2E",
	"LCPD2F",
	"LCPD3B",
	"LCPD4B",
	"LCPD6A",
	"LCPDT6A",

    -- Vanilla
    "police3",
    "police",
}

-- Vehicles that have moving parts assigned to bomb bay doors (e.g. highrisers)
ModelsWithRiser =
{
    -- New Wave RP
	"FDLCLADDER",
	"LCPD4B",
}

------------------------------------
-- VEHICLES WITH ALTERNATE SIRENS --
------------------------------------

ModelsWithWhelenCHPSiren =
{
    "sahp",
    "sahp1a",
    "sahp1b",
    "sahp1b2",
    "sahp1d",
    "sahp1e",
    "sahp2",
    "sahp2a",
}

ModelsWithFireSrn = -- vanilla fire truck siren
{
    -- New Wave RP
	"FDLCHAZMAT",
	"FDLCHEAVY",
	"FDLCLADDER",
	"FDLCRESCUE",
	"FDLCTRUCK",

    -- Vanilla
	"FIRETRUK",
}

ModelsWithAstroSpectra = 
{
    "LSFDGRANGER",
}

ModelsWithMastercomB = 
{
    "glpdalamo",

    "rhpdstanier",

    "sadcrrumpo",
    "sadcrstanier",
    "sadcrstank9",
}

ModelsWithNergy400 = 
{
    "fbi"
}

ModelsWithPA500 = -- Vanilla FIB Siren
{
    "sahp1b3",
    "sahp1c",
    "sahp2b",
}

ModelsWithSS2000 =
{
    -- PolicingMP
    "centurionlspd",
    "glpdstanier",
    
    -- New Wave RP
	"LCPD2F",
	"LCPD4B",
    
    -- Vanilla
    "police",
}

ModelsWithCencomSapphire = 
{
    "bcfdbat",
    "glpdbisonum",
    "glpdgresleyum",
    "rhpdscoutumk",
}

ModelsWith295HFS = {
    "centurionfib",
    "centurionlssd",
    "riot3",
}

ModelsWithSSP3000 =
{
    -- PolicingMP
    "bcsonalamo",
    "bcsospeedo",
    "dppdcara",
    "dppdcara2",
    "dppdcaraspare",
    "dppdscout",
    "dppdscoutk9",
    "dppdscoutsgt",
    "dppdscoutunmk",
    "lsiaops1",
    "lsiaops2",

    -- New Wave RP
	"LCPD2E",
	"LCPD3B",
	"LCPD6A",
	"LCPDT6A",
    
    -- Vanilla
    "police3",
}

ModelsWithTouchmaster = 
{
    "dppd",
    "dppdk9",
    "dppdsgt",
    "dppdunmk",
}

ModelsWithZ3 = 
{
    "cfpdscout",
    "cfpdtorrence",
    "cfpdalamo",

    "glpdbison",
    "glpdgresley",
    "glpdscout",

    "rhpdfug",
    "rhpdfugumk",
    "rhpdscout",
    "rhpdscoutk9",
    "rhpdscoutslick",

    "sadcrnscout",
    "sadcrtorrence",
    "sadcrtorrslick",
}

-----------------------------------
-- VEHICLES WITH ALTERNATE TONES --
------------------------------------

ModelsWithLAFDSpectraWail = -- LAFD Wail Tone in LXSRN 1 (Wail). Will only work with vehicles that are also in ModelsWithAstroSpectra list.
{
    "LSFDGRANGER",
}

ModelsWithLASDHorn = -- Classic Whelen Horn
{
    "glpdstanier",
}

ModelsWithFireHorn = -- Uses vanilla fire truck horn, does not interrupt main siren
{
    "FIRETRUK",
}

ModelsWithCencomCarbideUltra = -- Ultra Hi-Lo tone from Whelen Cencom Carbide in LXSRN 4 (Quarternary/Hilo)
{
    "bcfdbat",
}