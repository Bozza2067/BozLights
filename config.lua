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
    "sheriffretro",
    "sheriffretro2",
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
    "polprem",
    "polpremslick",
    "polpremumk",
    "gtfminivan",
    "centurionlspd",
    "polthrust",
    "policeb",
    "parkprem",
    "pranger",
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
    "sheriffalamo",
    "sheriffcq4",
    "sherifffug",
    "sheriffoss",
    "sheriffroamer",
    "sheriffrumpo",
    "sheriffscout",
    "sheriffscoutnew",
    "sheriffstalker",
    "sheriffthrust",
    "sherprem",
    "sherprem2",
    "sheriffold2",
    "sheriffold3",
    "sheriffriataold",
    "sheriffslick",
    "sheriffcont",
    "sheriffintc",
    "sheriffscoutold",
    "sheriffoffroad",
    "sheriffghost",
    "sheriffheavy",
    "sheriffshark",
    "sheriffboat",
    "sheriffcoqm3",
    "sheriffcoqmumk",
    "lssherbufac",
    "police2a",
    "police2c",
    "police2gs",
    "policebufac",
    "lsppalamo",
    "lsppscout",
    "lsppscoutk9",
    "lsppscoutum",
    "lsppstanier",
    "lsppstanier2",
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
    "lcpdh1b",
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
    "parkprem",
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
    "sheriffscoutnew",
    "sherprem2",
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
    "police42old",
    "rhpdfug",
    "rhpdfugumk",
    "rhpdscout",
    "rhpdscoutk9",
    "rhpdscoutslick",
    "rhpdstanier",
    "sheriffscout2",
    "sheriffslick",
    "sheriffoss",
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
    "sheriffcoqm3",
    "sheriffcoqmumk",
    "police2c",
    "policebufac",
}

ModelsWithRumbler = {
	"crimetaxi",
    "dppdscout",
    "dppdscoutk9",
    "dppdscoutsgt",
    "dppdscoutunmk",
    "lsiaops1",
    "lsiaops2",
    "lcpdh1b",
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
    "sheriffscout2",
    "sheriffcoqm3",
    "sheriffcoqmumk",
    "police2a",
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
    "sheriffthrust",
    "sheriffshark",
    "sheriffboat",
}

ModelsWith80K = {
    "policeold1",
    "policeold2",
    "polprem",
    "polpremslick",
    "polpremumk",
    "parkprem",
    "sherprem2",
    "sheriffold2",
    "sheriffold3",
    "sheriffriataold",
    "police2gs",
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
    "lsppalamo",
    "lsppscout",
    "lsppscoutk9",
    "lsppstanier",
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
    "sherprem",
    "sheriffalamoold",
    "sheriffsar",
    "sheriffvanold",
    "sheriffmoon",
    "sherifftrike",
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
    "crimetaxi",
	"LCPD2F",
	"LCPD4B",
    "lifeguard",
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
    "sheriffinsurgent",
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
    "lcpdh1b",
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
    "sheriffinsurgent",
    "sheriffscoutnew",
    "sheriffstalker",
    "sheriffghost",
    "sheriffscout2",
    "sheriffcoqm3",
    "sheriffcoqmumk",
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
    "rhpdfug",
    "rhpdfugumk",
    "rhpdscout",
    "rhpdscoutk9",
    "rhpdscoutslick",
    "sadcrnscout",
    "sadcrtorrence",
    "sadcrtorrslick",
    "lsppscoutum",
}

ModelsWithSmartSystemLMS = { -- LASD/LAPD Siren
    "glpdstanier",
    "police",
    "policeslick",
    "police2",
    "polspeedo",
    "polsadlerk9",
    "police4",
    "police42old",
    "gtfminivan",
    "centurionlspd",
    "sheriff",
    "sheriff2",
    "sheriffalamo",
    "sheriffcq4",
    "sherifffug",
    "sheriffroamer",
    "sheriffrumpo",
    "sheriffscout",
    "sheriffcont",
    "sheriffintc",
    "sheriffscoutold",
    "sheriffoffroad",
    "sheriffenduro",
    "sheriffslick",
    "sheriffoss",
    "lssherbufac",
    "police2a",
    "police2c",
    "policebufac",
    "lsppstanier2",
}

ModelsWith650RemoteSiren = {
    "sheriffheavy",
}

-----------------------------------
-- VEHICLES WITH ALTERNATE TONES --
------------------------------------

ModelsWithLAFDSpectraWail = { -- LAFD Wail Tone in LXSRN 1 (Wail). Will only work with vehicles that are also in ModelsWithAstroSpectra list.
    "ambulance",
    "firetruk",
    "LSFDGRANGER",
}

ModelsWithFireHorn = { -- Uses vanilla fire truck horn, does not interrupt main siren
    "ambulance",
    "firetruk",
}

ModelsWithCencomCarbideUltra = { -- Ultra Hi-Lo tone from Whelen Cencom Carbide in LXSRN 4 (Quarternary/Hilo)
    "bcfdbat",
}