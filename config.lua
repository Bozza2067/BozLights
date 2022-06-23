MuteHornToneSwitcher = true
UsingVanillaSiren = false -- UNUSED AS OF RIGHT NOW
ShowDebugInfo = false
TertiaryToneByDefault = true -- UNUSED AS OF RIGHT NOW

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

    "cfpdalamo2",
    "cfpdalamok9",
    "cfpdscout",
    "cfpdscout2",
    "cfpdstanier",
    "cfpdtorrence",
    "cfpdtorrenceum",

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
    "dppdscoutvol",

    "glpdalamo",
    "glpdalamo2",
    "glpdbison",
    "glpdbisonum",
    "glpdgresley",
    "glpdgresleyum",
    "glpdscout",
    "glpdstanier",

    "LSFDGRANGER",

    "mrcaalamo",
    "mrcacara",
    
    "ranchopdalamo",
    "ranchopdscout",
    "ranchopdscoutk9",

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
    
    "amb_rox_sheriff2",
    "amb_rox_swat",
}

-- Vehicles with a 4th tone activated by a seperate button. Usually a Hi-Lo.
ModelsWithQuarternaryTone = 
{
    -- PolicingMP
    "bcfdbat",
    "bcsonalamo",
    "bcsospeedo",
    "cfpdalamo2",
    "cfpdscout",
    "cfpdscout2",
    "cfpdtorrence",
    "ranchopdalamo",
    "ranchopdscout",
    "ranchopdscoutk9",
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
    "policeold1",
    "policeold2",
}

-- Vehicles with dual sirens
ModelsWithAuxiliaryTone = 
{
    "cfpdalamo2",
    "cfpdscout",
    "cfpdscout2",
    "cfpdtorrence",
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
    "ranchopdalamo",
    "ranchopdscout",
    "ranchopdscoutk9",
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

ModelsWithBMWIntegratedSiren =
{
    "polthrust",
}

ModelsWith80K = 
{
    "policeold1",
    "policeold2",
}

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

ModelsWithOmega90 = 
{
    "police",
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
    "cfpdstanier",
    "cfpdalamok9",
    "glpdstanier",
    
    -- New Wave RP
	"LCPD2F",
	"LCPD4B",
    
    -- Vanilla
    "police2",
    "police4",
}

ModelsWithCencomSapphire = 
{
    "bcfdbat",
    "cfpdtorrenceum",
    "glpdbisonum",
    "glpdgresleyum",
    "mrcacara",
    "rhpdscoutumk",
}

ModelsWith295HFS = {
    "centurionfib",
    "centurionlssd",
    "riot3",
    "amb_rox_sheriff2",
    "amb_rox_swat",
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
    "dppdscoutvol",
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
    "cfpdalamo2",
    "cfpdscout",
    "cfpdscout2",
    "cfpdtorrence",

    "glpdbison",
    "glpdgresley",
    "glpdscout",

    "mrcaalamo",
    
    "ranchopdalamo",
    "ranchopdscout",
    "ranchopdscoutk9",

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