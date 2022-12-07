MuteHornToneSwitcher = true
UsingVanillaSiren = false
ShowDebugInfo = false
DisableEquipmentWhenDamaged = false
DamageThreshold = 975
TertiaryToneByDefault = false -- UNUSED AS OF RIGHT NOW

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
	"lsiasectorrence",
	"lsiasecspeedo",
	"gcstanier",
	"gcstanier2",
	"gcscout",
	"dppdscoutvol",
	"mcsocara3",
	"coroner",
	"coroner2",
}

ModelsWithNoEquipment = { -- Non-emergency models without lights/sirens controls
	"glpdalamo2",
	"pbus",
	"sheriffretro",
	"sheriffretro2",
}

---------------
-- BOZLIGHTS --
---------------
--[[
	Extras:
	1: BOZLIGHTS - Steady Burn and Low-Level Lighting (Stages 2 and 3)
	2: BOZLIGHTS - Only the TA Pattern (Stage 1 only)
	3: BOZLIGHTS - Main Lighting (Stage 3 only)
	4: BOZLIGHTS - Auxiliary Lighting (These lights deactivate when high beams are active)
	5: BOZLIGHTS - Extra Lighting if Needed (Stage 3 only)
	6: BOZLIGHTS - Extra Lighting if Needed (Stage 3 only)
	7: BOZLIGHTS - Left Side Alley Light
	8: BOZLIGHTS - Right Side Alley Light
	9: Beanbag shotgun, found in the front
	10: Shotgun, found in the front
	11: Carbine Rifle, found in the front
	12: Partition

]]

ModelsWithBozLights = {
}

ModelsWithBozLightsLegacy = {
}

-- These models have extralights and sirens in the same spot that should not conflict on light stages two or three. 
-- All models here must also be in the eModelsWithBozLightsLegacy or eModelsWithBozLights arrays.
eModelsWithBLCTkdn =
	{
	}

eModelsWithAlleyLights = -- pretty evident what this means
	{
	}

eModelsWithMiniSrn = -- These vehicles only have two light stages (required to also be in eModelsWithBozLights (legacy works too probably?))
	{
	}

------------------------------------
-- VEHICLES WITH SPECIAL FEATURES --
------------------------------------

-- Vehicles with no third tone: Useful for california-compliant sirens that only have Wail and Yelp.
ModelsWithNoTertiaryTone = {
	"adspscout",
	"amb_rox_sheriff2",
	"amb_rox_swat",
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
	"lsiascoutII",
	"lsiastanierk9",
	"lsiastanier",
	"lsiastanierumk",
	"lsiafug",
	"lsiasectorrence",
	"lsiasecspeedo",
	"mcsoalamo",
	"mcsoalamo2",
	"mcsoalamo3",
	"mcsocara",
	"mcsocara2",
	"mcsocara3",
	"mcsoscout",
	"mcsoscout2",
	"mcsoscout3",
	"mcsoscout4",
	"mcsostalker",
	"mcsostanier",
	"mcsostanier2",
	"mcsotorr",
	"mcsotorr2",
	"mcsoyosemite",
	"mcfdtruck",
	"mcfdrescue",
	"mcfdhazmat",
	"bombsemite",
	"batstalker",
	"lspdstalker",
	"uniems",
	"unipd",
	"unipd2",
	"unipd4",
	"policefug2",
	"policefug3",
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
	"polnspeedo",
	"ambulance2",
	"coroner",
	"pdumksx",
	"sahp3",
	"sahp3a",
	"sahp3b",
	"sahp4",
	"sahp5",
	"sahp5a",
	"sahp6",
	"sahp6a",
	"sahpb",
	"sahpb2",
	"sahp4a",
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
	"mrcaalamo",
	"gcstanier",
	"gcstanier2",
	"gcscout",
	"mcfdtruck",
	"mcfdrescue",
	"mcfdhazmat",
	"senalamo5",
	"senalamo6",
	"sahp3",
	"sahp3a",
	"sahp3b",
	"sahp4",
	"sahp5",
	"sahp5a",
	"sahp6",
	"sahp6a",
	"sahpb",
	"sahpb2",
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
	"mcfdtruck",
	"mcfdrescue",
	"mcfdhazmat",
	"emsnspeedo",
	"ambulance22",
	"ambulance2",
	"emsbisonamb",
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
	"mcsoalamo",
	"mcsoalamo3",
	"mcsocara2",
	"mcsocara3",
	"mcsoscout",
	"mcsoscout4",
	"bombsemite",
	"polroamer",
	"policefug2",
	"policefug3",
	"polnspeedo",
	"pdumksx",
	"lspdbsq1",
	"sahp4a",
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
	"bombsemite",
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

ModelsWith480K = {
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

ModelsWithWhelenCHPSiren = {
	"sahp",
	"sahp1a",
	"sahp1b",
	"sahp1b2",
	"sahp1d",
	"sahp1e",
	"sahp2",
	"sahp2a",
	"sahp3",
	"sahp3a",
	"sahp3b",
	"sahp4",
	"sahp5",
	"sahp5a",
	"sahp6",
	"sahp6a",
}

ModelsWithWhelenCHPMotorSiren = {
	"sahpb",
	"sahpb2",
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
	"LSFDGRANGER",
	"ambulance2",
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
	"lspdstalker",
}

ModelsWithNergy400 = {
	"fbi",
	"fbi2",
	"senalamo5",
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
	"polroamer",
	"emsroamer",
	"coroner2",
	"lspdbsq1",
}

ModelsWithFIBSiren = { -- Vanilla FIB Siren
	"sahp1b3",
	"sahp1c",
	"sahp2b",
	"sahpprem",
	"sahppremslick",
	"sahp4a",
}

ModelsWithSS2000 = {
	"centurionlspd",
	"cfpdstanier",
	"cfpdalamok9",
	"crimetaxi",
	"LCPD2F",
	"LCPD4B",
	"lifeguard",
	"mcsooutlaw",
	"unipd",
	"unipd4",
}

ModelsWithCencomSapphire = {
	"bcfdbat",
	"cfpdtorrenceum",
	"glpdbisonum",
	"glpdgresleyum",
	"mrcacara",
	"rhpdscoutumk",
	"mcfdtruck",
	"mcfdrescue",
	"mcfdhazmat",
	"senalamo6",
}

ModelsWith295HFS = {
	"amb_rox_sheriff2",
	"amb_rox_swat",
	"centurionfib",
	"centurionlssd",
	"sheriffinsurgent",
	"riot2",
	"riot3",
	"mcsocenturion",
	"senalamo",
	"senalamo2",
	"senalamo3",
	"senalamo4",
	"senstalker",
	"emsnspeedo",
	"ambulance22",
	"emsbisonamb",
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
	"lsiascoutII",
	"lsiafug",
	"lsiasectorrence",
	"lsiasecspeedo",
	"mcsoalamo",
	"mcsoalamo3",
	"mcsocara2",
	"mcsocara3",
	"mcsoscout",
	"mcsoscout4",
	"bombsemite",
	"uniems",
	"unipd2",
	"policefug2",
	"policefug3",
	"gcscout",
	"polnspeedo",
	"coroner",
	"pdumksx",
}

ModelsWithTouchmaster = {
	"dppd",
	"dppdk9",
	"dppdsgt",
	"dppdunmk",
	"pranger",
	"mcsoalamo2",
	"mcsocara",
	"mcsoscout2",
	"mcsoscout3",
	"mcsostalker",
	"mcsostanier",
	"mcsostanier2",
	"mcsotorr",
	"mcsotorr2",
	"mcsoyosemite",
	"batstalker",
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
	"rhpdfugumk",
	"rhpdfug",
	"rhpdscoutslick",
	"rhpdscout",
	"rhpdscoutk9",
	"sadcrnscout",
	"sadcrtorrence",
	"sadcrtorrslick",
	"lsppscoutum",
	"policefug",
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
	"lsiastanierk9",
	"lsiastanier",
	"lsiastanierumk",
	"gcstanier",
	"gcstanier2",
}

ModelsWith650RemoteSiren = {
	"sheriffheavy",
}

ModelsWithEQ2 = { -- NOT WORKING

}

ModelsWithScientificPrototypesMk7Siren = {

}

ModelsWithPA300Siren = {

}

ModelsWithSS2000SS = {

}

-----------------------------------
-- VEHICLES WITH ALTERNATE TONES --
------------------------------------

ModelsWithLAFDSpectraWail = { -- LAFD Wail Tone in LXSRN 1 (Wail). Will only work with vehicles that are also in ModelsWithAstroSpectra list.
	"LSFDGRANGER",
	"ambulance2",
}

ModelsWithTimberwolfDualSiren = {

}

ModelsWithEQ2DualSiren = {
	"ambulance2",
}

ModelsWithQ2DualSiren = { 
	"mcfdtruck",
	"mcfdhazmat",
}

BCSOFugitiveModels = {
	"bcsofugitive",
	"fibpalamo",
	"fibpalamok9",
}

ModelsWithZ3LowFreqInsteadofHiLo = { -- Requires Z3 Siren
	"rhpdfug",
	"rhpdscoutslick",
}

ModelsWithFireHorn = { -- Uses vanilla fire truck horn, does not interrupt main siren
	"mcfdtruck",
	"mcfdhazmat",
	"ambulance2",
}

ModelsWithCencomCarbideUltra = { -- Ultra Hi-Lo tone from Whelen Cencom Carbide in LXSRN 4 (Quarternary/Hilo)
	"bcfdbat",
	"mcfdtruck",
	"mcfdrescue",
	"mcfdhazmat",
}