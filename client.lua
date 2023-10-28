--[[
---------------------------------------------------
LUXART VEHICLE CONTROL (FOR FIVEM)
---------------------------------------------------
Last revision: MAY 01 2017 (VERS. 1.01)
Coded by Lt.Caine
---------------------------------------------------
NOTES
	LVC will automatically apply to all emergency vehicles (vehicle class 18)
---------------------------------------------------
CONTROLS	
	Right indicator:	=	(Next Custom Radio Track)
	Left indicator:		-	(Previous Custom Radio Track)
	Hazard lights:	Backspace	(Phone Cancel)
	Toggle emergency lights:	Y	(Text Chat Team)
	Airhorn:	E	(Horn)
	Toggle siren:	,	(Previous Radio Station)
	Manual siren / Change siren tone:	N	(Next Radio Station)
	Auxiliary siren:	Down Arrow	(Phone Up)
---------------------------------------------------
]]

local count_bcast_timer = 0
local delay_bcast_timer = 1000

local count_sndclean_timer = 0
local delay_sndclean_timer = 400

local actv_ind_timer = false
local count_ind_timer = 0
local delay_ind_timer = 180

local actv_lxsrnmute_temp = false
local srntone_temp = 0
local dsrn_mute = true

local state_indic = {}
local state_lxsiren = {}
local state_pwrcall = {}
local state_airmanu = {}
local state_ltsg = {} -- bozlights

local ind_state_o = 0
local ind_state_l = 1
local ind_state_r = 2
local ind_state_h = 3

local snd_lxsiren = {}
local snd_pwrcall = {}
local snd_airmanu = {}


local pstate = 1
local fstate = 0

local rumblerState = 0
local SecondManualBrowserToneOption = 0
							
-- BOZLIGHTS START
local lstate = state_ltsg[veh]
local lstate = 0
-- BOZLIGHTS END
local idlelights = 0





-- DEBUGGING ----------------------------------------------------------------
function ShowDebug(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function ShowInfo(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	end
end)


RegisterCommand('togglevanillasirens', function()
	if not UsingVanillaSiren then
		UsingVanillaSiren = true
		SetResourceKvp("vanillasirensstatus", UsingVanillaSiren)
	else
		UsingVanillaSiren = false
		SetResourceKvp("vanillasirensstatus", UsingVanillaSiren)
	end
end)

RegisterKeyMapping('riser', 'Toggle Bomb Bay Doors', 'keyboard', '')
RegisterCommand('riser', function()
	local ped = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(ped, false)
	if useRiser(veh) then
		if not AreBombBayDoorsOpen(veh) then
			OpenBombBayDoors(veh)
		else
			CloseBombBayDoors(veh)
		end
	else
		PlaySoundFrontend(-1, "Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
	end
end)

RegisterKeyMapping('idlelights', 'Toggle Idle Lights', 'keyboard', 'X') -- Idle Lights Function
RegisterCommand('idlelights', function()
	local ped = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(ped, false)
	if UseIdleLights(veh) then
		if idlelights == 0 then
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			idlelights = 1
		else
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			idlelights = 0
		end
	end
end)

-- EXPERIMENTAL FEATURE, NOT IN USE AT THE MOMENT
--[[RegisterKeyMapping('toggleemergencylights', 'Toggle Emergency Lights', 'keyboard', 'J')
RegisterCommand('toggleemergencylights', function()
    local playerped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(playerped)
    if IsPedInAnyVehicle(playerped, false) and GetPedInVehicleSeat(veh, -1) == playerped and GetVehicleClass(veh) == 18 and not IsPauseMenuActive() then
        if IsVehicleSirenOn(veh) then
            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            SetVehicleSiren(veh, false)
        else
            PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            SetVehicleSiren(veh, true)
        end
    end	
end)]]

---------------------------------------------------------------------

-- BOZLIGHTS START
function useBozLights(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithBozLights, 1 do
		if model == GetHashKey(ModelsWithBozLights[i]) then
			return true
		end
	end
	return false
end

function useBozLightsLegacy(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithBozLightsLegacy, 1 do
		if model == GetHashKey(ModelsWithBozLightsLegacy[i]) then
			return true
		end
	end
	return false
end

function useBLCTkdn(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithBLCTkdn, 1 do
		if model == GetHashKey(eModelsWithBLCTkdn[i]) then
			return true
		end
	end
	return false
end

function useAlleyLights(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithAlleyLights, 1 do
		if model == GetHashKey(eModelsWithAlleyLights[i]) then
			return true
		end
	end
	return false
end

function useMiniSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithMiniSrn, 1 do
		if model == GetHashKey(eModelsWithMiniSrn[i]) then
			return true
		end
	end
	return false
end
-- BOZLIGHTS END

function UseFiretruckSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithFireSrn, 1 do
		if model == GetHashKey(ModelsWithFireSrn[i]) then
			return true
		end
	end
	return false
end
function UseFiretruckHorn(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithFireHorn, 1 do
		if model == GetHashKey(ModelsWithFireHorn[i]) then
			return true
		end
	end
	return false
end

function HasNoTertiaryTone(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithNoTertiaryTone, 1 do
		if model == GetHashKey(ModelsWithNoTertiaryTone[i]) then
			return true
		end
	end
	return false
end

function HasQuarternaryTone(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithQuarternaryTone, 1 do
		if model == GetHashKey(ModelsWithQuarternaryTone[i]) then
			return true
		end
	end
	return false
end

function HasAuxiliaryTone(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithAuxiliaryTone, 1 do
		if model == GetHashKey(ModelsWithAuxiliaryTone[i]) then
			return true
		end
	end
	return false
end

function HasHornSwitch(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithHornSwitch, 1 do
		if model == GetHashKey(ModelsWithHornSwitch[i]) then
			return true
		end
	end
	return false
end

function UseFIBSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithFIBSiren, 1 do
		if model == GetHashKey(ModelsWithFIBSiren[i]) then
			return true
		end
	end
	return false
end

function Use295HFS(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWith295HFS, 1 do
		if model == GetHashKey(ModelsWith295HFS[i]) then
			return true
		end
	end
	return false
end

function UseZ3Siren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithZ3, 1 do
		if model == GetHashKey(ModelsWithZ3[i]) then
			return true
		end
	end
	return false
end

function UseOmega90(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithOmega90, 1 do
		if model == GetHashKey(ModelsWithOmega90[i]) then
			return true
		end
	end
	return false
end

function UseNERGY(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithNergy400, 1 do
		if model == GetHashKey(ModelsWithNergy400[i]) then
			return true
		end
	end
	return false
end

function UseCHPSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithWhelenCHPSiren, 1 do
		if model == GetHashKey(ModelsWithWhelenCHPSiren[i]) then
			return true
		end
	end
	return false
end
function UseCHPMotorSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithWhelenCHPMotorSiren, 1 do
		if model == GetHashKey(ModelsWithWhelenCHPMotorSiren[i]) then
			return true
		end
	end
	return false
end

function UseSS2000(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithSS2000, 1 do
		if model == GetHashKey(ModelsWithSS2000[i]) then
			return true
		end
	end
	return false
end

function Use480K(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWith480K, 1 do
		if model == GetHashKey(ModelsWith480K[i]) then
			return true
		end
	end
	return false
end

function UseBMWSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithBMWIntegratedSiren, 1 do
		if model == GetHashKey(ModelsWithBMWIntegratedSiren[i]) then
			return true
		end
	end
	return false
end

function UseSSP3000(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithSSP3000, 1 do
		if model == GetHashKey(ModelsWithSSP3000[i]) then
			return true
		end
	end
	return false
end

function HasNoEquipment(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithNoEquipment, 1 do
		if model == GetHashKey(ModelsWithNoEquipment[i]) then
			return true
		end
	end
	return false
end

function HasRumbler(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithRumbler, 1 do
		if model == GetHashKey(ModelsWithRumbler[i]) then
			return true
		end
	end
	return false
end

function HasEquipment(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithEquipment, 1 do
		if model == GetHashKey(ModelsWithEquipment[i]) then
			return true
		end
	end
	return false
end

function UseMastercomB(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithMastercomB, 1 do
		if model == GetHashKey(ModelsWithMastercomB[i]) then
			return true
		end
	end
	for i = 1, #BCSOFugitiveModels, 1 do
		if model == GetHashKey(BCSOFugitiveModels[i]) then
			if IsVehicleExtraTurnedOn(veh, 1) then
				return true
			end
		end
	end
	return false
end

function UseAstroSpectra(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithAstroSpectra, 1 do
		if model == GetHashKey(ModelsWithAstroSpectra[i]) then
			return true
		end
	end
	return false
end

function UseSAHPHiLo(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithSAHPHiLo, 1 do
		if model == GetHashKey(ModelsWithSAHPHiLo[i]) then
			return true
		end
	end
	return false
end

function UseLAFDSpectraWail(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithLAFDSpectraWail, 1 do
		if model == GetHashKey(ModelsWithLAFDSpectraWail[i]) then
			return true
		end
	end
	return false
end

function UseSSLMS(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithSmartSystemLMS, 1 do
		if model == GetHashKey(ModelsWithSmartSystemLMS[i]) then
			return true
		end
	end
	return false
end

function UsePA640(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithPA640, 1 do
		if model == GetHashKey(ModelsWithPA640[i]) then
			return true
		end
	end
	return false
end

function UseCencomRed(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithCencomRed, 1 do
		if model == GetHashKey(ModelsWithCencomRed[i]) then
			return true
		end
	end
	return false
end

function UseSapphire(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithCencomSapphire, 1 do
		if model == GetHashKey(ModelsWithCencomSapphire[i]) then
			return true
		end
	end
	for i = 1, #BCSOFugitiveModels, 1 do
		if model == GetHashKey(BCSOFugitiveModels[i]) then
			if IsVehicleExtraTurnedOn(veh, 2) then
				return true
			end
		end
	end
	return false
end

function UseCarbideUltra(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithCencomCarbideUltra, 1 do
		if model == GetHashKey(ModelsWithCencomCarbideUltra[i]) then
			return true
		end
	end
	return false
end

function UseTouchmaster(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithTouchmaster, 1 do
		if model == GetHashKey(ModelsWithTouchmaster[i]) then
			return true
		end
	end
	return false
end

function Use650RS(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWith650RemoteSiren, 1 do
		if model == GetHashKey(ModelsWith650RemoteSiren[i]) then
			return true
		end
	end
	return false
end

function UseAS350Siren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #AS350Helicopters, 1 do
		if model == GetHashKey(AS350Helicopters[i]) then
			return true
		end
	end
	return false
end

function useRiser(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithRiser, 1 do
		if model == GetHashKey(ModelsWithRiser[i]) then
			return true
		end
	end
	return false
end

function UseIdleLights(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithIdleLights, 1 do
		if model == GetHashKey(ModelsWithIdleLights[i]) then
			return true
		end
	end
	return false
end

function DontUseParkKill(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithoutSirenParkKill, 1 do
		if model == GetHashKey(ModelsWithoutSirenParkKill[i]) then
			return true
		end
	end
	return false
end

function UseZ3SirenLowFreq(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithZ3LowFreqInsteadofHiLo, 1 do
		if model == GetHashKey(ModelsWithZ3LowFreqInsteadofHiLo[i]) then
			return true
		end
	end
	return false
end

function UseTimberwolfDual(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithTimberwolfDualSiren, 1 do
		if model == GetHashKey(ModelsWithTimberwolfDualSiren[i]) then
			return true
		end
	end
	return false
end

function UseEQ2Dual(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithEQ2DualSiren, 1 do
		if model == GetHashKey(ModelsWithEQ2DualSiren[i]) then
			return true
		end
	end
	return false
end

function UseEQ2(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithEQ2, 1 do
		if model == GetHashKey(ModelsWithEQ2[i]) then
			return true
		end
	end
	return false
end

function UseQ2Dual(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithQ2DualSiren, 1 do
		if model == GetHashKey(ModelsWithQ2DualSiren[i]) then
			return true
		end
	end
	return false
end

function UseSPM7Siren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithScientificPrototypesMk7Siren, 1 do
		if model == GetHashKey(ModelsWithScientificPrototypesMk7Siren[i]) then
			return true
		end
	end
	return false
end

function UsePA300Siren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithPA300Siren, 1 do
		if model == GetHashKey(ModelsWithPA300Siren[i]) then
			return true
		end
	end
	return false
end

function Use940Siren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithTomar940, 1 do
		if model == GetHashKey(ModelsWithTomar940[i]) then
			return true
		end
	end
	return false
end

function UseSS2000SS(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithSS2000SS, 1 do
		if model == GetHashKey(ModelsWithSS2000SS[i]) then
			return true
		end
	end
	return false
end


---------------------------------------------------------------------
function CleanupSounds()
	if count_sndclean_timer > delay_sndclean_timer then
		count_sndclean_timer = 0
		for k, v in pairs(state_lxsiren) do
			if v > 0 then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_lxsiren[k] ~= nil then
						StopSound(snd_lxsiren[k])
						ReleaseSoundId(snd_lxsiren[k])
						snd_lxsiren[k] = nil
						state_lxsiren[k] = nil
					end
				end
			end
		end
		for k, v in pairs(state_pwrcall) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_pwrcall[k] ~= nil then
						StopSound(snd_pwrcall[k])
						ReleaseSoundId(snd_pwrcall[k])
						snd_pwrcall[k] = nil
						state_pwrcall[k] = nil
					end
				end
			end
		end
		for k, v in pairs(state_airmanu) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k, -1) then
					if snd_airmanu[k] ~= nil then
						StopSound(snd_airmanu[k])
						ReleaseSoundId(snd_airmanu[k])
						snd_airmanu[k] = nil
						state_airmanu[k] = nil
					end
				end
			end
		end
	else
		count_sndclean_timer = count_sndclean_timer + 1
	end
end

---------------------------------------------------------------------
function TogIndicStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate == ind_state_o then
			SetVehicleIndicatorLights(veh, 0, false) -- R
			SetVehicleIndicatorLights(veh, 1, false) -- L
		elseif newstate == ind_state_l then
			SetVehicleIndicatorLights(veh, 0, false) -- R
			SetVehicleIndicatorLights(veh, 1, true) -- L
		elseif newstate == ind_state_r then
			SetVehicleIndicatorLights(veh, 0, true) -- R
			SetVehicleIndicatorLights(veh, 1, false) -- L
		elseif newstate == ind_state_h then
			SetVehicleIndicatorLights(veh, 0, true) -- R
			SetVehicleIndicatorLights(veh, 1, true) -- L
		end
		state_indic[veh] = newstate
	end
end

---------------------------------------------------------------------
function TogMuteDfltSrnForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		DisableVehicleImpactExplosionActivation(veh, toggle)
	end
end

---------------------------------------------------------------------
function SetLxSirenStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_lxsiren[veh] then
				
			if snd_lxsiren[veh] ~= nil then
				StopSound(snd_lxsiren[veh])
				ReleaseSoundId(snd_lxsiren[veh])
				snd_lxsiren[veh] = nil
			end
						
			if newstate == 1 then
				snd_lxsiren[veh] = GetSoundId()	
				if UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "collision_i8o7bp", veh, 0, 0, 0)
				elseif UseFIBSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "resident_vehicles_siren_wail_02", veh, 0, 0, 0)
				elseif UsingVanillaSiren then
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				elseif UseCHPSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_chp_wail", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseCencomRed(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_red_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif Use940Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_940_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UsePA640(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_pa640_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseCHPMotorSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_chp2_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif Use295HFS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_295hfs_wail", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSS2000SS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000ss_wail", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UseSPM7Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_spmark7_wail", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UsePA300Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_pa300_wail", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UseZ3Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_z3_wail", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseNERGY(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_nergy_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_omega_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseBMWSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_hansch_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif Use480K(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_480k_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif Use650RS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_650rs_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseSapphire(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_sapphire_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseTouchmaster(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_touchmaster_wail", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseAstroSpectra(veh) then
					if UseLAFDSpectraWail(veh) then
						PlaySoundFromEntity(snd_lxsiren[veh], "siren_spectra_wail2", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
					else
						PlaySoundFromEntity(snd_lxsiren[veh], "siren_spectra_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
					end
				elseif UseMastercomB(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_mastercom_b_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ssp3000_wail", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
				
			elseif newstate == 2 then
				snd_lxsiren[veh] = GetSoundId()	
				if UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "collision_q3nurz", veh, 0, 0, 0)
				elseif UseFIBSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "resident_vehicles_siren_quick_02", veh, 0, 0, 0)
				elseif UsingVanillaSiren then
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
				elseif UseCHPSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_chp_yelp", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseCHPMotorSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_chp2_yelp", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif Use295HFS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_295hfs_yelp", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseCencomRed(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_red_yelp", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UsePA640(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_pa640_yelp", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif Use940Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_940_yelp", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseSS2000SS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000ss_yelp", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UseSPM7Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_spmark7_yelp", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UsePA300Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_pa300_yelp", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UseZ3Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_z3_yelp", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseNERGY(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_nergy_yelp", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_omega_yelp", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseBMWSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_hansch_yelp", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif Use480K(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_480k_yelp", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif Use650RS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_650rs_priority", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000_yelp", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSapphire(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_sapphire_yelp", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseTouchmaster(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_touchmaster_yelp", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseAstroSpectra(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_spectra_yelp", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseMastercomB(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_mastercom_b_yelp", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ssp3000_yelp", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
			
			elseif newstate == 3 then
				snd_lxsiren[veh] = GetSoundId()
				if UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
				elseif UsingVanillaSiren then
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_POLICE_WARNING", veh, 0, 0, 0)
				elseif UseZ3Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_z3_hyperyelp", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif Use295HFS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_295hfs_priority", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseCencomRed(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_red_pier", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UsePA640(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_pa640_prty", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseSS2000SS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000ss_priority", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif Use940Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_940_hyper", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseSPM7Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_spmark7_hilo", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UsePA300Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_pa300_wail", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UseNERGY(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_nergy_yelp_reverse", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSS2000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000_priority", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSSLMS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000_priority_lms", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseTouchmaster(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_touchmaster_priority", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_omega_priority", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				--elseif Use480K(veh) then
				--	PlaySoundFromEntity(snd_lxsiren[veh], "siren_480k_hilofast", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseSapphire(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_sapphire_priority", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseMastercomB(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_mastercom_b_priority", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ssp3000_priority", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_POLICE_WARNING", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
			
			elseif newstate == 4 then
				snd_lxsiren[veh] = GetSoundId()
				if UseCarbideUltra(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_carbide_ultra", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UsingVanillaSiren then
					PlaySoundFromEntity(snd_lxsiren[veh], "vehicles_horns_police_warning_rnd_euro", veh, 0, 0, 0)

				elseif UseCHPSiren(veh) or UseCHPMotorSiren(veh) or UseSAHPHiLo(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_chp_evac", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseZ3Siren(veh) then
					if UseZ3SirenLowFreq(veh) then
						PlaySoundFromEntity(snd_lxsiren[veh], "siren_z3_lowfreq", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
					else
						PlaySoundFromEntity(snd_lxsiren[veh], "siren_z3_hilo", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
					end
				elseif UseNERGY(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_nergy_hilo", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) or UseSS2000SS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000_hilo", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_omega_hilo", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				--elseif Use480K(veh) then
				--	PlaySoundFromEntity(snd_lxsiren[veh], "siren_480k_hilo", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseTouchmaster(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_touchmaster_ultra", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif Use940Siren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_940_hilo", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseAstroSpectra(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_spectra_hilo", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ssp3000_hilo", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "vehicles_horns_police_warning_rnd_euro", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
			
			elseif newstate == 5 then
				snd_lxsiren[veh] = GetSoundId()
				if UsingVanillaSiren then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_pa20a_wail_r", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ssp3000_wail_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000_wail_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_pa20a_wail_r", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				end
			
			elseif newstate == 6 then
				snd_lxsiren[veh] = GetSoundId()
				if UsingVanillaSiren then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_2_r", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ssp3000_yelp_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000_yelp_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_2_r", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				end
			
			elseif newstate == 7 then
				snd_lxsiren[veh] = GetSoundId()
				if UsingVanillaSiren then
					PlaySoundFromEntity(snd_lxsiren[veh], "police_warning_r", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ssp3000_priority_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000_priority_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "police_warning_r", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				end
			
			elseif newstate == 8 then
				snd_lxsiren[veh] = GetSoundId()
				if UsingVanillaSiren then
					PlaySoundFromEntity(snd_lxsiren[veh], "vehicles_horns_police_warning_rnd_euro", veh, 0, 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ssp3000_hilo_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_ss2000_hilo_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "vehicles_horns_police_warning_rnd_euro", veh, 0, 0, 0)
				end
			
			elseif newstate == 9 then
				snd_lxsiren[veh] = GetSoundId()
				if UsingVanillaSiren then
					PlaySoundFromEntity(snd_lxsiren[veh], "vehicles_horns_siren_1", veh, 0, 0, 0)
				elseif UseTouchmaster(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_touchmaster_wail2", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_omega_wail2", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif Use480K(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_480k_wail2", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
				
			else
				TogMuteDfltSrnForVeh(veh, true)
			end				
				
			state_lxsiren[veh] = newstate
		end
	end
end

---------------------------------------------------------------------
function TogPowercallStateForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if toggle == true then
			if snd_pwrcall[veh] == nil then
				snd_pwrcall[veh] = GetSoundId()
				if UseTimberwolfDual(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_timberwolf", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseEQ2Dual(veh) or UseEQ2(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_eq2_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseQ2Dual(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_q2a", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "collision_i8o7bp", veh, 0, 0, 0)
				elseif UseFIBSiren(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "resident_vehicles_siren_wail_02", veh, 0, 0, 0)
				elseif UsingVanillaSiren then
					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				elseif UseCHPSiren(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_chp_wail", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif Use940Siren(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_940_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseCHPMotorSiren(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_chp2_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseZ3Siren(veh) then
					if state_lxsiren[veh] == 2 then
						PlaySoundFromEntity(snd_pwrcall[veh], "siren_z3_yelp", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
					else
						PlaySoundFromEntity(snd_pwrcall[veh], "siren_z3_wail", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
					end
				elseif Use295HFS(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_295hfs_wail", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSPM7Siren(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_spmark7_wail", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UsePA300Siren(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_pa300_wail", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UseNERGY(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_nergy_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseCencomRed(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_red_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UsePA640(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_pa640_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseBMWSiren(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_hansch_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif Use480K(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_480k_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseSS2000(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_ss2000_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSSLMS(veh) or UseSS2000SS(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_480k_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_omega_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseTouchmaster(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_touchmaster_wail", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSapphire(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_sapphire_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseAstroSpectra(veh) then
					if UseLAFDSpectraWail(veh) then
						PlaySoundFromEntity(snd_pwrcall[veh], "siren_spectra_wail2", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
					else
						PlaySoundFromEntity(snd_pwrcall[veh], "siren_spectra_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
					end
				elseif UseMastercomB(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "siren_mastercom_b_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					if state_lxsiren[veh] == 2 or state_lxsiren[veh] == 6 then
						PlaySoundFromEntity(snd_pwrcall[veh], "siren_touchmaster_yelp", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
					elseif state_lxsiren[veh] == 3 or state_lxsiren[veh] == 7 then
						PlaySoundFromEntity(snd_pwrcall[veh], "siren_touchmaster_priority", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
					elseif state_lxsiren[veh] == 4 or state_lxsiren[veh] == 8 then
						PlaySoundFromEntity(snd_pwrcall[veh], "siren_touchmaster_ultra", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
					else
						PlaySoundFromEntity(snd_pwrcall[veh], "siren_touchmaster_wail", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
					end
				else
					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				end
			end
		else
			if snd_pwrcall[veh] ~= nil then
				StopSound(snd_pwrcall[veh])
				ReleaseSoundId(snd_pwrcall[veh])
				snd_pwrcall[veh] = nil
			end
		end
		state_pwrcall[veh] = toggle
	end
end

---------------------------------------------------------------------
function SetAirManuStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
				
			if snd_airmanu[veh] ~= nil then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end
						
			if newstate == 1 then
				snd_airmanu[veh] = GetSoundId()
				if HasHornSwitch(veh) and not IsVehicleSirenOn(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "stretch_multi_horn", veh, 0, 0, 0)

				elseif UseFiretruckSiren(veh) or UseFiretruckHorn(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "fire_horn", veh, 0, 0, 0)
				elseif UseFIBSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "stretch_multi_horn", veh, 0, 0, 0)
				elseif UsingVanillaSiren then
					PlaySoundFromEntity(snd_airmanu[veh], "sirens_airhorn", veh, 0, 0, 0)
						
				elseif UseSSLMS(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_ss2000_horn_lms", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseCHPSiren(veh) or UseCHPMotorSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_chp_horn", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseZ3Siren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_z3_horn", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif Use295HFS(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_295hfs_horn", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseTouchmaster(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_touchmaster_horn", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif Use940Siren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_940_horn", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseNERGY(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_nergy_horn", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSS2000SS(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_ss2000ss_horn", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UseSPM7Siren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_spmark7_horn", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UsePA300Siren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_pa300_horn", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UseBMWSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_hansch_horn", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif Use650RS(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_650rs_horn", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif Use480K(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_480k_horn", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseMastercomB(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_mastercom_b_horn", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseCencomRed(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_red_horn", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UsePA640(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_pa640_horn", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_omega_horn", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseSapphire(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_sapphire_horn", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSS2000(veh) then
					if HasHornSwitch(veh) then
						PlaySoundFromEntity(snd_airmanu[veh], "siren_ss2000_manual", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
					else
						PlaySoundFromEntity(snd_airmanu[veh], "siren_ss2000_horn", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
					end
				elseif UseAstroSpectra(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_spectra_horn", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					if HasHornSwitch(veh) then
						PlaySoundFromEntity(snd_airmanu[veh], "siren_ssp3000_manual", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
					else
					PlaySoundFromEntity(snd_airmanu[veh], "siren_ssp3000_horn", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
					end
				else
					PlaySoundFromEntity(snd_airmanu[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
				end
				
			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				if UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "collision_i8o7bp", veh, 0, 0, 0)
				elseif UseFIBSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "resident_vehicles_siren_wail_02", veh, 0, 0, 0)
				elseif UsingVanillaSiren then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_police_manual", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
					
				elseif UseCHPSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_chp_wail", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseAS350Siren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_as350", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseCHPMotorSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_chp2_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif Use940Siren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_940_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseZ3Siren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_z3_wail", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseNERGY(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_nergy_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif Use295HFS(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_295hfs_wail", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSPM7Siren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_spmark7_wail", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UsePA300Siren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_pa300_manual", veh, "policingmp_sounds_retrosirens_soundset", 0, 0)
				elseif UseBMWSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_hansch_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseCencomRed(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_red_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UsePA640(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_pa640_wail", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif Use480K(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_480k_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif Use650RS(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_650rs_manual", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseTouchmaster(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_touchmaster_manual", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseMastercomB(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_mastercom_b_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) or UseSS2000SS(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_ss2000_manual", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_omega_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				elseif UseSapphire(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_sapphire_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
				elseif UseAstroSpectra(veh) then
					if UseLAFDSpectraWail(veh) then
						PlaySoundFromEntity(snd_airmanu[veh], "siren_spectra_wail2", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
					else
						PlaySoundFromEntity(snd_airmanu[veh], "siren_spectra_wail", veh, "policingmp_sounds_sirens2_soundset", 0, 0)
					end
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_ssp3000_manual", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_airmanu[veh], "siren_police_manual", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				end
				
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				if UsingVanillaSiren then
					PlaySoundFromEntity(snd_airmanu[veh], "sirens_airhorn", veh, 0, 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_ssp3000_horn_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_ss2000_horn_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_omega_horn", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				end

			elseif newstate == 4 then
				snd_airmanu[veh] = GetSoundId()
				if UsingVanillaSiren then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_pa20a_wail_r", veh, "policingmp_sounds_sirens5_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_ssp3000_manual_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseSS2000(veh) or UseSSLMS(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_ss2000_wail_r", veh, "policingmp_sounds_sirens3_soundset", 0, 0)
				elseif UseOmega90(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "siren_omega_wail", veh, "policingmp_sounds_sirens4_soundset", 0, 0)
				end
				
			end				
				
			state_airmanu[veh] = newstate
		end
	end
end


---------------------------------------------------------------------
RegisterNetEvent("lvc_TogIndicState_c")
AddEventHandler("lvc_TogIndicState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogIndicStateForVeh(veh, newstate)
			end
		end
	end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_TogDfltSrnMuted_c")
AddEventHandler("lvc_TogDfltSrnMuted_c", function(sender, toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogMuteDfltSrnForVeh(veh, toggle)
			end
		end
	end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_SetLxSirenState_c")
AddEventHandler("lvc_SetLxSirenState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetLxSirenStateForVeh(veh, newstate)
			end
		end
	end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_TogPwrcallState_c")
AddEventHandler("lvc_TogPwrcallState_c", function(sender, toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogPowercallStateForVeh(veh, toggle)
			end
		end
	end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_SetAirManuState_c")
AddEventHandler("lvc_SetAirManuState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetAirManuStateForVeh(veh, newstate)
			end
		end
	end
end)

---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
			
			CleanupSounds()

			DistantCopCarSirens(false)

			RequestScriptAudioBank("DLC_POLICINGMPAUDIO\\POLICINGMP_SIRENS1", false)
			RequestScriptAudioBank("DLC_POLICINGMPAUDIO\\POLICINGMP_SIRENS2", false)
			RequestScriptAudioBank("DLC_POLICINGMPAUDIO\\POLICINGMP_SIRENS3", false)
			RequestScriptAudioBank("DLC_POLICINGMPAUDIO\\POLICINGMP_SIRENS4", false)
			RequestScriptAudioBank("DLC_POLICINGMPAUDIO\\POLICINGMP_SIRENS5", false)

			
			----- IS IN VEHICLE -----
			local playerped = GetPlayerPed(-1)		
			if IsPedInAnyVehicle(playerped, false) then	
			
				----- IS DRIVER -----
				local veh = GetVehiclePedIsUsing(playerped)	
				if GetPedInVehicleSeat(veh, -1) == playerped then
				
					DisableControlAction(0, 84, true) -- INPUT_VEH_PREV_RADIO_TRACK  
					DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK 

					-- Get speed in mph
					local speed = GetEntitySpeed(veh) * 2.236936
					
					if state_indic[veh] ~= ind_state_o and state_indic[veh] ~= ind_state_l and state_indic[veh] ~= ind_state_r and state_indic[veh] ~= ind_state_h then
						state_indic[veh] = ind_state_o
					end

					-- INDIC AUTO CONTROL
					if actv_ind_timer == true then	
						if state_indic[veh] == ind_state_l or state_indic[veh] == ind_state_r then
							if GetEntitySpeed(veh) < 6 then
								count_ind_timer = 0
							else
								if count_ind_timer > delay_ind_timer then
									count_ind_timer = 0
									actv_ind_timer = false
									state_indic[veh] = ind_state_o
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									TogIndicStateForVeh(veh, state_indic[veh])
									count_bcast_timer = delay_bcast_timer
								else
									count_ind_timer = count_ind_timer + 1
								end
							end
						end
					end

					-- close highriser if above 30mph
					if useRiser(veh) then
						if speed >= 30 and AreBombBayDoorsOpen(veh) then
							CloseBombBayDoors(veh)
						end
					end

					-- siren park kill
					if not DontUseParkKill(veh) then
						if IsControlPressed(0, 75) then
							SetLxSirenStateForVeh(veh, newstate)
							SetLxSirenStateForVeh(veh, 0)
							state_lxsiren[veh] = 0
							count_bcast_timer = delay_bcast_timer
						end
					end

					-- idle lights
					if idlelights == 0 then
						SetVehicleLights(veh, 0)
						SetVehicleExtra(veh, 12, true)
					elseif idlelights == 1 then
						SetVehicleLights(veh, 1)
						SetVehicleExtra(veh, 12, false)
					end

					--- IS EMERG VEHICLE ---
					if GetVehicleClass(veh) == 18 and not HasNoEquipment(veh) or HasEquipment(veh) then
						
						local actv_manu = false
						local actv_horn = false
						
						DisableControlAction(0, 86, true) -- INPUT_VEH_HORN	
						--DisableControlAction(0, 172, true) -- INPUT_CELLPHONE_UP 
						--DisableControlAction(0, 173, true) -- INPUT_CELLPHONE_DOWN
						--DisableControlAction(0, 174, true) -- INPUT_CELLPHONE_LEFT 
						--DisableControlAction(0, 175, true) -- INPUT_CELLPHONE_RIGHT 
						--DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
						--DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
						DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL 
						DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL 
						DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM 

						DisableControlAction(0, 157, true) -- INPUT_SELECT_WEAPON_UNARMED (1)
						DisableControlAction(0, 158, true) -- INPUT_SELECT_WEAPON_MELEE (2)
						DisableControlAction(0, 160, true) -- INPUT_SELECT_WEAPON_SHOTGUN (3)
						DisableControlAction(0, 164, true) -- INPUT_SELECT_WEAPON_HEAVY (4) ()
						DisableControlAction(0, 165, true) -- INPUT_SELECT_WEAPON_SPECIAL (5) (Auxiliary)
						DisableControlAction(0, 159, true) -- INPUT_SELECT_WEAPON_HANDGUN (6) (Rumbler)

					
						SetVehRadioStation(veh, "OFF")
						SetVehicleRadioEnabled(veh, false)
						
						if state_lxsiren[veh] ~= 1 and state_lxsiren[veh] ~= 2 and state_lxsiren[veh] ~= 3 and state_lxsiren[veh] ~= 4 and state_lxsiren[veh] ~= 5 and state_lxsiren[veh] ~= 6 and state_lxsiren[veh] ~= 7 and state_lxsiren[veh] ~= 8 and state_lxsiren[veh] ~= 9 then
							state_lxsiren[veh] = 0
						end
						if state_pwrcall[veh] ~= true then
							state_pwrcall[veh] = false
						end
						if state_airmanu[veh] ~= 1 and state_airmanu[veh] ~= 2 and state_airmanu[veh] ~= 3 and state_airmanu[veh] ~= 4 then
							state_airmanu[veh] = 0
						end

						-- BOZLIGHTS START
						if state_ltsg[veh] ~= 1 and state_ltsg[veh] ~= 2 and state_ltsg[veh] ~= 3 then
							state_ltsg[veh] = 0
						end
						-- BOZLIGHTS END

						if ShowDebugInfo == true then
							ShowInfo(tostring(state_lxsiren[veh]) .. tostring(state_airmanu[veh]) .. tostring(state_pwrcall[veh]))
						end

						TogMuteDfltSrnForVeh(veh, true)
						dsrn_mute = true
						
						if IsVehicleSirenOn(veh) and IsFirstPersonAimCamActive() then
							ShowInfo("Your emergency lights are active.")
						end

						if not IsVehicleSirenOn(veh) and state_lxsiren[veh] > 0 then
							PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
							SetLxSirenStateForVeh(veh, 0)
							count_bcast_timer = delay_bcast_timer
						end
						if not IsVehicleSirenOn(veh) and state_pwrcall[veh] == true then
							PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
							TogPowercallStateForVeh(veh, false)
							count_bcast_timer = delay_bcast_timer
						end

						-- BOZLIGHTS START
						if useBozLightsLegacy(veh) or useBozLights(veh) then
							if lstate == 1 then
								SetVehicleAutoRepairDisabled(veh, true)
								SetVehicleExtra(veh, 1, true)
								SetVehicleExtra(veh, 2, false)
								SetVehicleExtra(veh, 3, true)
								SetVehicleExtra(veh, 4, true)
								if useBozLights(veh) then
									SetVehicleExtra(veh, 5, true)
									SetVehicleExtra(veh, 6, true)
								end
							elseif lstate == 2 then
								SetVehicleAutoRepairDisabled(veh, true)
								SetVehicleExtra(veh, 1, false)
								SetVehicleExtra(veh, 2, false)
								SetVehicleExtra(veh, 3, true)
								SetVehicleExtra(veh, 4, true)
								if useBozLights(veh) then
									SetVehicleExtra(veh, 5, true)
									SetVehicleExtra(veh, 6, true)
								end
							elseif lstate == 3 then
								SetVehicleAutoRepairDisabled(veh, true)
								SetVehicleExtra(veh, 1, false)
								SetVehicleExtra(veh, 2, true)
								SetVehicleExtra(veh, 3, false)
								SetVehicleExtra(veh, 4, false)
								if useBozLights(veh) then
									SetVehicleExtra(veh, 5, false)
									SetVehicleExtra(veh, 6, false)
								end
							elseif lstate == 0 then
								SetVehicleAutoRepairDisabled(veh, true)
								SetVehicleExtra(veh, 1, true)
								SetVehicleExtra(veh, 2, true)
								SetVehicleExtra(veh, 3, true)
								SetVehicleExtra(veh, 4, true)
								if useBozLights(veh) then
									SetVehicleExtra(veh, 5, true)
									SetVehicleExtra(veh, 6, true)
								end
							end
						end
						-- BOZLIGHTS END

						if not HasRumbler(veh) then
							rumblerState = 0
						end
					
						----- CONTROLS -----
						if not IsPauseMenuActive() and UpdateOnscreenKeyboard() ~= 0 then
							if GetVehicleBodyHealth(veh) < DamageThreshold and DisableEquipmentWhenDamaged then
								SetLxSirenStateForVeh(veh, 0)
								SetVehicleSiren(veh, false)
								count_bcast_timer = delay_bcast_timer
								ShowInfo("Your emergency equipment has been damaged and no longer functions.")

							-- BOZLIGHTS START
							elseif IsDisabledControlJustReleased(0, 85) then
								--BOZLIGHTS START
								if useBozLights(veh) or useBozLightsLegacy(veh) then
									if lstate == 3 then
										PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
										SetVehicleSiren(veh, false)
										lstate = 0
									elseif lstate ~= 3 then
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
										SetVehicleSiren(veh, true)
										if useMiniSiren(veh) and lstate == 0 then
											lstate = 2
										else 
											lstate = lstate + 1
										end
										count_bcast_timer = delay_bcast_timer
									end
								else
								-- BOZLIGHTS END
									if IsVehicleSirenOn(veh) then
										PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
										SetVehicleSiren(veh, false)
									else
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
										SetVehicleSiren(veh, true)
										count_bcast_timer = delay_bcast_timer
									end
								end		-- BOZLIGHTS
							-- BOZLIGHTS END

							--[[elseif IsDisabledControlJustReleased(0, 85) then
								if IsVehicleSirenOn(veh) then
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									SetVehicleSiren(veh, false)
								else
									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									SetVehicleSiren(veh, true)
									count_bcast_timer = delay_bcast_timer
								end		]]
							
							-- TOG BOZ SIREN (NEW)

							elseif IsDisabledControlJustPressed(0, 157) and not UseAS350Siren(veh) then
								local cstate = state_lxsiren[veh]
								if not useBozLights(veh) then
									if not useBozLightsLegacy(veh) then
										lstate = 3
									end
								end
								if cstate == 2 and UseTouchmaster(veh) or UseOmega90(veh) and cstate == 2 or Use480K(veh) and cstate == 2 then
									local sirenoption = math.random(0,1)
									if IsVehicleSirenOn(veh) then
										PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
										if sirenoption == 1 then
											SetLxSirenStateForVeh(veh, 9)
										else 
											SetLxSirenStateForVeh(veh, 1)
										end
										count_bcast_timer = delay_bcast_timer
									end
								elseif cstate ~= 1 and cstate ~= 5 and cstate ~= 9 then
									if IsVehicleSirenOn(veh) or GetVehicleClass == 15 then
										PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
										if rumblerState == 1 then
											SetLxSirenStateForVeh(veh, 5)
										else
											SetLxSirenStateForVeh(veh, 1)
										end
										count_bcast_timer = delay_bcast_timer
									end
								else
									PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
									SetLxSirenStateForVeh(veh, 0)
									count_bcast_timer = delay_bcast_timer
								end
							elseif IsDisabledControlJustPressed(0, 158) and not UseAS350Siren(veh) then
								local cstate = state_lxsiren[veh]
								if not useBozLights(veh) then
									if not useBozLightsLegacy(veh) then
										lstate = 3
									end
								end
								if cstate ~= 2 and cstate ~= 6 then
									if IsVehicleSirenOn(veh) then
										PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
										if rumblerState == 1 then
											SetLxSirenStateForVeh(veh, 6)
										else
											SetLxSirenStateForVeh(veh, 2)
										end
										count_bcast_timer = delay_bcast_timer
									end
								else
									PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
									SetLxSirenStateForVeh(veh, 0)
									count_bcast_timer = delay_bcast_timer
								end
							elseif IsDisabledControlJustPressed(0, 160) and GetVehicleClass(veh) ~= 15 then
								if not HasNoTertiaryTone(veh) and not UseBMWSiren(veh) and not Use650RS(veh) then
									local cstate = state_lxsiren[veh]
									if not useBozLights(veh) then
										if not useBozLightsLegacy(veh) then
											lstate = 3
										end
									end

									if cstate ~= 3 and cstate ~= 7 then
										if IsVehicleSirenOn(veh) then

											PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)

											if SmartSirenBeep then
												if UseSS2000(veh) or UseSSLMS(veh) then
													if rumblerState == 1 then
														SetLxSirenStateForVeh(veh, 8)
													else
														SetLxSirenStateForVeh(veh, 4)
													end
													Citizen.Wait(100)
												end
											end

											if rumblerState == 1 then
												SetLxSirenStateForVeh(veh, 7)
											else
												SetLxSirenStateForVeh(veh, 3)
											end
											
											count_bcast_timer = delay_bcast_timer
										end
									else
										PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
										SetLxSirenStateForVeh(veh, 0)
										count_bcast_timer = delay_bcast_timer
									end
								else
									PlaySoundFrontend(-1, "Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
								end
							elseif IsDisabledControlJustPressed(0, 164) and GetVehicleClass(veh) ~= 15 then
								if HasQuarternaryTone(veh) then
									local cstate = state_lxsiren[veh]
									if not useBozLights(veh) then
										if not useBozLightsLegacy(veh) then
											lstate = 3
										end
									end
									if cstate ~= 4 and cstate ~= 8 then
										if IsVehicleSirenOn(veh) then
											PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
											if rumblerState == 1 then
												SetLxSirenStateForVeh(veh, 8)
											else
												SetLxSirenStateForVeh(veh, 4)
											end
											count_bcast_timer = delay_bcast_timer
										end
									else
										PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
										SetLxSirenStateForVeh(veh, 0)
										count_bcast_timer = delay_bcast_timer
									end
								else
									PlaySoundFrontend(-1, "Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
								end
								
							elseif IsDisabledControlJustPressed(0, 159) and GetVehicleClass(veh) ~= 15 then
								local cstate = state_lxsiren[veh]
								if not useBozLights(veh) then
									if not useBozLightsLegacy(veh) then
										lstate = 3
									end
								end
								if HasRumbler(veh) then
									PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
									if rumblerState == 0 then
										rumblerState = 1
										if cstate ~= 0 then
											SetLxSirenStateForVeh(veh, cstate + 4)
										end
									else
										rumblerState = 0
										SetLxSirenStateForVeh(veh, cstate - 4)
									end
								else
									PlaySoundFrontend(-1, "Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
								end

							-- TOG LX SIREN
							elseif IsDisabledControlJustPressed(0, 19) and GetVehicleClass(veh) ~= 15 then
								local cstate = state_lxsiren[veh]
								if not useBozLights(veh) then
									if not useBozLightsLegacy(veh) then
										lstate = 3
									end
								end

								if cstate == 0 then
									if not useBozLights(veh) and IsVehicleSirenOn(veh) or useBozLights(veh) and lstate == 3 or not useBozLightsLegacy(veh) and IsVehicleSirenOn(veh) or useBozLightsLegacy(veh) and lstate == 3 then -- bozlights
									--if IsVehicleSirenOn(veh) then
										PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
										if rumblerState == 1 then
											SetLxSirenStateForVeh(veh, 5)
										else
											SetLxSirenStateForVeh(veh, 1)
										end
										count_bcast_timer = delay_bcast_timer
									end
								else
									PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
									SetLxSirenStateForVeh(veh, 0)
									count_bcast_timer = delay_bcast_timer
								end
							
							-- TOG LX SIREN (HORN)
							elseif IsDisabledControlJustReleased(0,86) and HasHornSwitch(veh) and GetVehicleClass(veh) ~= 15 then
								local timer = GetGameTimer()
								while true do
									if IsControlJustPressed(0, 86) then
										local cstate = state_lxsiren[veh]
										if cstate == 0 then
											if not useBozLights(veh) and IsVehicleSirenOn(veh) or useBozLights(veh) and lstate == 3 or not useBozLightsLegacy(veh) and IsVehicleSirenOn(veh) or useBozLightsLegacy(veh) and lstate == 3  then -- bozlights
											--if IsVehicleSirenOn(veh) then
												PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
												SetLxSirenStateForVeh(veh, 1)
												count_bcast_timer = delay_bcast_timer
											end
										else
											PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
											SetLxSirenStateForVeh(veh, 0)
											count_bcast_timer = delay_bcast_timer
										end
									end
									if (GetGameTimer() - timer >= 100) then
										break
									end
									Citizen.Wait(0)
								end
								
							-- TOG AUXILIARY TONE
							elseif IsDisabledControlJustPressed(0, 165) and GetVehicleClass(veh) ~= 15 then
								--if HasAuxiliaryTone(veh) then -- bozlights
								if HasAuxiliaryTone(veh) then
									if state_pwrcall[veh] == true then
										PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
										TogPowercallStateForVeh(veh, false)
										count_bcast_timer = delay_bcast_timer
									else
										if IsVehicleSirenOn(veh) then
											PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
											TogPowercallStateForVeh(veh, true)
											count_bcast_timer = delay_bcast_timer
										end
									end
								else
									PlaySoundFrontend(-1, "Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
								end
							end

							-- BROWSE LX SRN TONES
							if state_lxsiren[veh] > 0 then
								if IsDisabledControlJustPressed(0, 80) or (IsDisabledControlJustPressed(0, 86) and HasHornSwitch(veh)) then
									local cstate = state_lxsiren[veh]
									local nstate = 1
									if IsVehicleSirenOn(veh) and GetVehicleClass(veh) ~= 15 then
										--PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
										if cstate == 1 or cstate == 5 or cstate == 9 then
											if rumblerState == 1 then
												nstate = 6
											else
												nstate = 2
											end
										else
											local sirenoption = math.random(0,1)
											if rumblerState == 1 then
												nstate = 5
											elseif (UseTouchmaster(veh) or UseOmega90(veh) or Use480K(veh)) and sirenoption == 1 then
												nstate = 9
											else
												nstate = 1
											end
										end
										SetLxSirenStateForVeh(veh, nstate)
										count_bcast_timer = delay_bcast_timer
									end
								end

								-- BOZLIGHTS START
								-- TAKEDOWN SHUTOFF AT HBEAMS
								if useBLCTkdn(veh) then
									if lstate == 3 then
										_,lightson,highbeams = GetVehicleLightsState(veh)
										local tkdnlights = IsVehicleExtraTurnedOn(veh, 4)
										if highbeams == 1 then
											SetVehicleAutoRepairDisabled(veh, true)
											SetVehicleExtra(veh, 4, tkdnlights)
										end
									elseif lstate == 2 then
										_,lightson,highbeams = GetVehicleLightsState(veh)
										local sbrnlights = IsVehicleExtraTurnedOn(veh, 1)
										if highbeams == 1 then
											SetVehicleAutoRepairDisabled(veh, true)
											--SetVehicleExtra(veh, 1, sbrnlights)
										end
									elseif lstate == 3 then
										_,lightson,highbeams = GetVehicleLightsState(veh)
										local sbrnlights = IsVehicleExtraTurnedOn(veh, 1)
										local tkdnlights = IsVehicleExtraTurnedOn(veh, 4)
										if highbeams == 1 then
											SetVehicleAutoRepairDisabled(veh, true)
											--SetVehicleExtra(veh, 1, sbrnlights)
											SetVehicleExtra(veh, 4, tkdnlights)
										end
									end
								end
								-- BOZLIGHTS END
							end

							if IsDisabledControlJustPressed(0, 80) or (IsDisabledControlJustPressed(0, 86) and (not HasHornSwitch(veh) or HasHornSwitch(veh) and state_lxsiren[veh] ~= 0)) then
								if GetVehicleClass(veh) ~= 15 then
									PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
								end
							end
										
							-- MANU
							if state_lxsiren[veh] < 1 then
								if IsDisabledControlPressed(0, 80) then
									if not IsUsingKeyboard(0) and GetVehicleClass(veh) == 15 then 
										actv_manu = false
									else
										actv_manu = true
									end
								else
									actv_manu = false
								end
							else
								actv_manu = false
							end

							-- HORN SIREN TOGGLL
							if IsDisabledControlPressed(0, 86) and GetVehicleClass(veh) ~= 15 and (not HasHornSwitch(veh) or (HasHornSwitch(veh) and state_lxsiren[veh] == 0)) then
								if HasHornSwitch(veh) and IsVehicleSirenOn(veh) and state_lxsiren[veh] >~ 0 then
									local timer = GetGameTimer()
									if (GetGameTimer() - timer > 100) then
										actv_horn = true
									end
								else
								actv_horn = true
								end
							else
								actv_horn = false
							end
						
						end
						
						---- ADJUST HORN / MANU STATE ----
						local hmanu_state_new = 0
						if actv_horn == true and actv_manu == false then
							if rumblerState == 1 then
								hmanu_state_new = 3
							else
								hmanu_state_new = 1
							end
						elseif actv_horn == false and actv_manu == true then
							if rumblerState == 1 then
								hmanu_state_new = 4
							else
								hmanu_state_new = 2
							end
						elseif actv_horn == true and actv_manu == true then
							if rumblerState == 1 then
								hmanu_state_new = 3
							else
								hmanu_state_new = 1
							end
						end
						if hmanu_state_new == 1 or hmanu_state_new == 3 then
							if not UseFiretruckSiren(veh) and not UseFiretruckHorn(veh) then
								if state_lxsiren[veh] > 0 and actv_lxsrnmute_temp == false then
									if state_lxsiren[veh] == 9 and not Use480K(veh) then
										srntone_temp = 1
									else
										srntone_temp = state_lxsiren[veh]
									end
									SetLxSirenStateForVeh(veh, 0)
									actv_lxsrnmute_temp = true
								end
							end
						else
							if not UseFiretruckSiren(veh) and not UseFiretruckHorn(veh) then
								if actv_lxsrnmute_temp == true then
									SetLxSirenStateForVeh(veh, srntone_temp)
									actv_lxsrnmute_temp = false
								end
							end
						end
						if state_airmanu[veh] ~= hmanu_state_new then
							SetAirManuStateForVeh(veh, hmanu_state_new)
							count_bcast_timer = delay_bcast_timer
						end	
					end
					
						
					--- IS ANY LAND VEHICLE ---	
					if GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 and GetVehicleClass(veh) ~= 21 then
					
						----- CONTROLS -----
						if not IsPauseMenuActive() and UpdateOnscreenKeyboard() ~= 0 then
						
							-- IND L
							if IsDisabledControlJustReleased(0, 84) then -- INPUT_VEH_PREV_RADIO_TRACK
								local cstate = state_indic[veh]
								if cstate == ind_state_l then
									state_indic[veh] = ind_state_o
									actv_ind_timer = false
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
								else
									state_indic[veh] = ind_state_l
									actv_ind_timer = true
									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
								end
								TogIndicStateForVeh(veh, state_indic[veh])
								count_ind_timer = 0
								count_bcast_timer = delay_bcast_timer			
							-- IND R
							elseif IsDisabledControlJustReleased(0, 83) then -- INPUT_VEH_NEXT_RADIO_TRACK
								local cstate = state_indic[veh]
								if cstate == ind_state_r then
									state_indic[veh] = ind_state_o
									actv_ind_timer = false
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
								else
									state_indic[veh] = ind_state_r
									actv_ind_timer = true
									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
								end
								TogIndicStateForVeh(veh, state_indic[veh])
								count_ind_timer = 0
								count_bcast_timer = delay_bcast_timer
							-- IND H
							elseif IsControlJustReleased(0, 202) then -- INPUT_FRONTEND_CANCEL / Backspace
								if GetLastInputMethod(0) then -- last input was with kb
									local cstate = state_indic[veh]
									if cstate == ind_state_h then
										state_indic[veh] = ind_state_o
										PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									else
										state_indic[veh] = ind_state_h
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									end
									TogIndicStateForVeh(veh, state_indic[veh])
									actv_ind_timer = false
									count_ind_timer = 0
									count_bcast_timer = delay_bcast_timer
								end
							end
						
						end
						
						
						----- AUTO BROADCAST VEH STATES -----
						if count_bcast_timer > delay_bcast_timer then
							count_bcast_timer = 0
							--- IS EMERG VEHICLE ---
							if GetVehicleClass(veh) == 18 or HasEquipment(veh) then
								TriggerServerEvent("lvc_TogDfltSrnMuted_s", dsrn_mute)
								TriggerServerEvent("lvc_SetLxSirenState_s", state_lxsiren[veh])
								TriggerServerEvent("lvc_TogPwrcallState_s", state_pwrcall[veh])
								TriggerServerEvent("lvc_SetAirManuState_s", state_airmanu[veh])
							end
							--- IS ANY OTHER VEHICLE ---
							TriggerServerEvent("lvc_TogIndicState_s", state_indic[veh])
						else
							count_bcast_timer = count_bcast_timer + 1
						end
					
					end
					
				end
			end
			
		Citizen.Wait(0)
	end
end)
