MuteHornToneSwitcher = true
UsingVanillaSiren = false
ShowDebugInfo = false
TertiaryToneByDefault = true -- UNUSED AS OF RIGHT NOW

----------------------
-- ENABLED VEHICLES --
----------------------

-- By default, only vehicles in the emergency class will have light/siren control features. Here you can adjust that on a per-car basis.
-- Non-emergency models with lights/sirens controls.
ModelsWithEquipment = {
    "lsiaops1",
    "lsiaops2",
    "lsiaops3",
    "riot3",
    "sadcrnscout",
    "sadcrrumpo",
    "sadcrstanier",
    "sadcrstank9",
    "sadcrtorrence",
    "sadcrtorrslick",
}

ModelsWithNoEquipment = { -- Non-emergency models without lights/sirens controls
    "glpdalamo2",
    "pbus",
}

------------------------------------
-- VEHICLES WITH SPECIAL FEATURES --
------------------------------------

-- Vehicles with no third tone: Useful for california-compliant sirens that only have Wail and Yelp.
ModelsWithNoTertiaryTone = {
    "adspscout",
    "amb_rox_sheriff2",
    "amb_rox_swat",
    "ambulance",
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
    "firetruk",
    "glpdalamo",
    "glpdalamo2",
    "glpdbison",
    "glpdbisonum",
    "glpdgresley",
    "glpdgresleyum",
    "glpdscout",
    "glpdstanier",
    "gtfminivan",
    "lifeguard",
    "LSFDGRANGER",
    "lsiaops1",
    "lsiaops2",
    "mrcaalamo",
    "mrcacara",
    "parkprem",
    "police",
    "policeslick",
    "police2",
    "police3",
    "pscout",
    "pscoutnew",
    "poleveron",
    "polspeedo",
    "polsadlerk9",
    "police4",
    "police42old",
    "gtfminivan",
    "centurionlspd",
    "polthrust",
    "policeb",
    "pranger",
    "ranchopdalamo",
    "ranchopdscout",
    "ranchopdscoutk9",
    "riot",
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
    "sheriff",
    "sheriff2",
}

-- Vehicles with a 4th tone activated by a seperate button. Usually a Hi-Lo.
ModelsWithQuarternaryTone = {
    "adspscout",
    "bcfdbat",
    "bcsonalamo",
    "bcsospeedo",
    "cfpdalamo2",
    "cfpdscout",
    "cfpdscout2",
    "cfpdtorrence",
	"crimetaxi",
	"LCPD2E",
	"LCPD2F",
	"LCPD3B",
	"LCPD4B",
	"LCPD6A",
    "lcpd6aadl",
    "lcpd6aaqn",
    "lcpd6abahn",
    "lcpd6abkd",
	"LCPDT6A",
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
}

-- Vehicles with dual sirens
ModelsWithAuxiliaryTone = {
    "cfpdalamo2",
    "cfpdscout",
    "cfpdscout2",
    "cfpdtorrence",
    "dppd",
    "dppdk9",
    "dppdsgt",
    "dppdunmk",
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
ModelsWithHornSwitch = {
    "police",
    "policeold",
    "policeslick",
    "police2",
    "police3",
    "pscout",
    "pscoutnew",
    "poleveron",
    "polalamoold",
    "polspeedo",
    "polsadlerk9",
    "police4",
    "police42old",
    "gtfminivan",
    "centurionlspd",
    "polriot",
    "policeb",
    "policet",
    "sahp1b3",
    "sahp1c",
    "sahp2b",
    "sahpprem",
    "sahppremslick",
}

ModelsWithRumbler = {
	"crimetaxi",
    "dppdscout",
    "dppdscoutk9",
    "dppdscoutsgt",
    "dppdscoutunmk",
    "lsiaops1",
    "lsiaops2",
	"LCPD2E",
	"LCPD2F",
	"LCPD3B",
	"LCPD4B",
	"LCPD6A",
    "lcpd6aadl",
    "lcpd6aaqn",
    "lcpd6abahn",
    "lcpd6abkd",
	"LCPDT6A",
    "police2",
    "police4",
}

-- Vehicles that have moving parts assigned to bomb bay doors (e.g. highrisers)
ModelsWithRiser = {
	"FDLCLADDER",
	"LCPD4B",
}

------------------------------------
-- VEHICLES WITH ALTERNATE SIRENS --
------------------------------------

ModelsWithBMWIntegratedSiren = {
    "polthrust",
}

ModelsWith80K = {
    "policeold1",
    "policeold2",
    "police42old",
}

ModelsWithWhelenCHPSiren ={
    "sahp",
    "sahp1a",
    "sahp1b",
    "sahp1b2",
    "sahp1d",
    "sahp1e",
    "sahp2",
    "sahp2a",
}

ModelsWithFireSrn = { -- vanilla fire truck siren
	"FDLCHAZMAT",
	"FDLCHEAVY",
	"FDLCLADDER",
	"FDLCRESCUE",
	"FDLCTRUCK",
}

ModelsWithAstroSpectra = {
    "adspscout",
    "ambulance",
    "firetruk",
    "LSFDGRANGER",
}

ModelsWithMastercomB = {
    "glpdalamo",
    "rhpdstanier",
    "sadcrrumpo",
    "sadcrstanier",
    "sadcrstank9",
}

ModelsWithNergy400 = {
    "fbi",
    "fbi2",
}

ModelsWithOmega90 = {
    "lsiaops3",
    "policeold",
    "polalamoold",
    "polriot",
    "lspdb",
    "policet",
    "riot",
}

ModelsWithFIBSiren = { -- Vanilla FIB Siren
    "sahp1b3",
    "sahp1c",
    "sahp2b",
    "sahpprem",
    "sahppremslick",
}

ModelsWithSS2000 = {
    "centurionlspd",
    "cfpdstanier",
    "cfpdalamok9",
    "glpdstanier",
	"crimetaxi",
	"LCPD2F",
	"LCPD4B",
    "lifeguard",
    "police",
    "policeslick",
    "police2",
    "polspeedo",
    "polsadlerk9",
    "police4",
    "gtfminivan",
    "centurionlspd",
    "sheriff",
    "sheriff2",
}

ModelsWithCencomSapphire = {
    "bcfdbat",
    "cfpdtorrenceum",
    "glpdbisonum",
    "glpdgresleyum",
    "mrcacara",
    "rhpdscoutumk",
}

ModelsWith295HFS = {
    "amb_rox_sheriff2",
    "amb_rox_swat",
    "centurionfib",
    "centurionlssd",
    "riot2",
    "riot3",
}

ModelsWithSSP3000 = {
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
	"LCPD2E",
	"LCPD3B",
	"LCPD6A",
    "lcpd6aadl",
    "lcpd6aaqn",
    "lcpd6abahn",
    "lcpd6abkd",
	"LCPDT6A",
    "lsiaops1",
    "lsiaops2",
    "police3",
    "pscout",
    "pscoutnew",
    "poleveron",
}

ModelsWithTouchmaster = {
    "dppd",
    "dppdk9",
    "dppdsgt",
    "dppdunmk",
    "pranger",
}

ModelsWithZ3 = {
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

ModelsWithSAP500 = {
    "castellajp",
}

-----------------------------------
-- VEHICLES WITH ALTERNATE TONES --
------------------------------------

ModelsWithLAFDSpectraWail = { -- LAFD Wail Tone in LXSRN 1 (Wail). Will only work with vehicles that are also in ModelsWithAstroSpectra list.
    "ambulance",
    "firetruk",
    "LSFDGRANGER",
}

ModelsWithLASDHorn = { -- Classic Whelen Horn
    "glpdstanier",
    "sheriff",
    "sheriff2",
}

ModelsWithFireHorn = { -- Uses vanilla fire truck horn, does not interrupt main siren
    "ambulance",
    "firetruk",
}

ModelsWithCencomCarbideUltra = { -- Ultra Hi-Lo tone from Whelen Cencom Carbide in LXSRN 4 (Quarternary/Hilo)
    "bcfdbat",
}