MuteHornToneSwitcher = true
UsingVanillaSiren = false -- UNUSED AS OF RIGHT NOW

-- Vehicles with no third tone: Useful for california-compliant sirens that only have Wail and Yelp.
ModelsWithNoTertiaryTone = 
{
    "bcsonalamo",
    "glpdalamo",
    "glpdalamo2",
    "glpdbison",
    "glpdbisonum",
    "glpdgresley",
    "glpdgresleyum",
    "glpdscout",
    --"glpdstanier",
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
}

-- Vehicles with a 4th tone activated by a seperate button. Usually a Hi-Lo.
ModelsWithQuarternaryTone = 
{
    "bcsonalamo",

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
ModelsWithAuxiliaryTone = 
{
	
}

-- Vehicles that use the horn to change tones. Disabled electronic horn. Horn behavior: Regular car horn when lights off, manual tone when lights on, change tone when sirens on.
ModelsWithHornSwitch = 
{
    "bcsonalamo",
    
    "sahp1b3",
    "sahp1c",
    "sahp2b",
}

-- By default, vehicles in the emergency class will have light/siren control features. Put vehicles in this array that you don't want to be affected.
EmergencyModelsWithNoEquipment =
{
    "glpdalamo2",
}

---------------------------------------
-- VEHICLES WITH ALTERNATE SIRENS
---------------------------------------

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

ModelsWithPA500 =
{
    "sahp1b3",
    "sahp1c",
    "sahp2b",
}

ModelsWithZ3 = 
{
    "glpdalamo",
    "glpdalamo2",
    "glpdbison",
    "glpdbisonum",
    "glpdgresley",
    "glpdgresleyum",
    "glpdscout",
}

ModelsWithSS2000 =
{
    "glpdstanier",
}

ModelsWithSSP3000 =
{
    "bcsonalamo",

    "police3",
}

ModelsWithFireSrn = -- vanilla fire truck siren
{
	"FIRETRUK",
}