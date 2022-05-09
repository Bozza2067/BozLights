MuteHornToneSwitcher = true
UsingVanillaSiren = false -- UNUSED AS OF RIGHT NOW
ShowDebugInfo = false

----------------------
-- ENABLED VEHICLES --
----------------------
-- By default, vehicles in the emergency class will have light/siren control features. 
-- This section will let you define vehicles that don't conform to that default.

NonEmergencyModelsWithEquipment = 

}

EmergencyModelsWithNoEquipment =
{
    "glpdalamo2",
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
}

-- Vehicles with a 4th tone activated by a seperate button. Usually a Hi-Lo.
ModelsWithQuarternaryTone = 
{
    "bcfdbat",

    "bcsonalamo",
    "bcsospeedo",

    "rhpdfug",

    "sahp",
    "sahp1a",
    "sahp1b",
    "sahp1b2",
    "sahp1d",
    "sahp1e",
    "sahp2",
    "sahp2a",
    "fbi"
}

-- Vehicles with dual sirens
ModelsWithAuxiliaryTone = 
{
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
    "centurionlspd",
    "glpdstanier",
}

ModelsWithCencomSapphire = 
{
    "BCFDBAT",

    "rhpdscoutumk",
}

ModelsWithSSP3000 =
{
    "bcsonalamo",
    "bcsospeedo",
}

ModelsWithZ3 = 
{
    "glpdbison",
    "glpdbisonum",
    "glpdgresley",
    "glpdgresleyum",
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