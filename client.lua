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

local ind_state_o = 0
local ind_state_l = 1
local ind_state_r = 2
local ind_state_h = 3

local snd_lxsiren = {}
local snd_pwrcall = {}
local snd_airmanu = {}


local pstate = 1
local fstate = 0




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
	else
		UsingVanillaSiren = false
	end
end)

---------------------------------------------------------------------
function UseFiretruckSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithFireSrn, 1 do
		if model == GetHashKey(ModelsWithFireSrn[i]) then
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

function UsePA500(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithPA500, 1 do
		if model == GetHashKey(ModelsWithPA500[i]) then
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

function UseSS2000(veh)
	local model = GetEntityModel(veh)
	for i = 1, #ModelsWithSS2000, 1 do
		if model == GetHashKey(ModelsWithSS2000[i]) then
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
				if UseCHPSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_chp_wail", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "collision_i8o7bp", veh, 0, 0, 0)
				elseif UsePA500(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "resident_vehicles_siren_wail_02", veh, 0, 0, 0)
				elseif UseSS2000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "oiss_ssa_vehaud_etc_adam", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "oiss_ssa_vehaud_etc_henry", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
				
			elseif newstate == 2 then
				snd_lxsiren[veh] = GetSoundId()	
				if UseCHPSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_chp_yelp", veh, 0, 0, 0)
				elseif UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "collision_q3nurz", veh, 0, 0, 0)
				elseif UsePA500(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "resident_vehicles_siren_quick_02", veh, 0, 0, 0)
				elseif UseSS2000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "oiss_ssa_vehaud_etc_boy", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "oiss_ssa_vehaud_etc_ida", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
			
			elseif newstate == 3 then
				snd_lxsiren[veh] = GetSoundId()
				if UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
				elseif UseSS2000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "oiss_ssa_vehaud_etc_charles", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "oiss_ssa_vehaud_etc_john", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_POLICE_WARNING", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
			
			elseif newstate == 4 then
				snd_lxsiren[veh] = GetSoundId()
				if UseCHPSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "siren_chp_evac", veh, "policingmp_sounds_sirens1_soundset", 0, 0)
				elseif UseSS2000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "oiss_ssa_vehaud_etc_edward", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "oiss_ssa_vehaud_etc_lincoln", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "vehicles_horns_police_warning_rnd_euro", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
			
			elseif newstate == 5 then
				snd_lxsiren[veh] = GetSoundId()
				if UseSS2000(veh) then
					--PlaySoundFromEntity(snd_lxsiren[veh], "oiss_ssa_vehaud_etc_frank", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
					PlaySoundFromEntity(snd_lxsiren[veh], "sirens_euro_high", veh, 0, 0, 0)
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
				if UsePA500(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "resident_vehicles_siren_wail_02", veh, 0, 0, 0)
				elseif UseSS2000(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "oiss_ssa_vehaud_etc_adam", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "oiss_ssa_vehaud_etc_henry", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
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
				elseif UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_FIRETRUCK_WARNING", veh, 0, 0, 0)
				elseif UsePA500(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "stretch_multi_horn", veh, 0, 0, 0)
				elseif UseSS2000(veh) then
					if HasHornSwitch(veh) then
						PlaySoundFromEntity(snd_airmanu[veh], "oiss_ssa_vehaud_etc_george", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
					else
					PlaySoundFromEntity(snd_airmanu[veh], "oiss_ssa_vehaud_etc_david", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
					end
				elseif UseSSP3000(veh) then
					if HasHornSwitch(veh) then
						PlaySoundFromEntity(snd_airmanu[veh], "oiss_ssa_vehaud_etc_mary", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
					else
					PlaySoundFromEntity(snd_airmanu[veh], "oiss_ssa_vehaud_etc_king", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
					end
				else
					PlaySoundFromEntity(snd_airmanu[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
				end
				
			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				if UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "collision_i8o7bp", veh, 0, 0, 0)
				elseif UsePA500(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "resident_vehicles_siren_wail_02", veh, 0, 0, 0)
				elseif UseSS2000(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "oiss_ssa_vehaud_etc_george", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "oiss_ssa_vehaud_etc_mary", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				end
			
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				if UseFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "collision_q3nurz", veh, 0, 0, 0)
				elseif UsePA500(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "resident_vehicles_siren_quick_02", veh, 0, 0, 0)
				elseif UseSS2000(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "oiss_ssa_vehaud_etc_boy", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				elseif UseSSP3000(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "oiss_ssa_vehaud_etc_ida", veh, "oiss_ssa_vehaud_etc_soundset", 0, 0)
				else
					PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
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

RequestScriptAudioBank("DLC_POLICINGMPAUDIO\\POLICINGMP_SIRENS1", false)

---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
			
			CleanupSounds()

			RequestScriptAudioBank("DLC_POLICINGMPAUDIO\\POLICINGMP_SIRENS1", false)

			
			----- IS IN VEHICLE -----
			local playerped = GetPlayerPed(-1)		
			if IsPedInAnyVehicle(playerped, false) then	
			
				----- IS DRIVER -----
				local veh = GetVehiclePedIsUsing(playerped)	
				if GetPedInVehicleSeat(veh, -1) == playerped then
				
					DisableControlAction(0, 84, true) -- INPUT_VEH_PREV_RADIO_TRACK  
					DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK 
					
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
					
					
					--- IS EMERG VEHICLE ---
					if GetVehicleClass(veh) == 18 then
						
						local actv_manu = false
						local actv_horn = false
						
						DisableControlAction(0, 86, true) -- INPUT_VEH_HORN	
						DisableControlAction(0, 172, true) -- INPUT_CELLPHONE_UP 
						--DisableControlAction(0, 173, true) -- INPUT_CELLPHONE_DOWN
						--DisableControlAction(0, 174, true) -- INPUT_CELLPHONE_LEFT 
						--DisableControlAction(0, 175, true) -- INPUT_CELLPHONE_RIGHT 
						DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
						DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
						DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL 
						DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL 
						DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM 
					
						SetVehRadioStation(veh, "OFF")
						SetVehicleRadioEnabled(veh, false)
						
						if state_lxsiren[veh] ~= 1 and state_lxsiren[veh] ~= 2 and state_lxsiren[veh] ~= 3 and state_lxsiren[veh] ~= 4 and state_lxsiren[veh] ~= 5 then
							state_lxsiren[veh] = 0
						end
						if state_pwrcall[veh] ~= true then
							state_pwrcall[veh] = false
						end
						if state_airmanu[veh] ~= 1 and state_airmanu[veh] ~= 2 and state_airmanu[veh] ~= 3 then
							state_airmanu[veh] = 0
						end
						ShowInfo(fstate .. "vanilla " .. tostring(UsingVanillaSiren) .. " switchmute " .. tostring(MuteHornToneSwitcher) .. "    lxsiren " .. tostring(state_lxsiren[veh]) .. " airmanu " .. tostring(state_airmanu[veh] .. " pwrcall " .. tostring(state_pwrcall[veh]) .. "    timer " .. count_bcast_timer))
						
						if UseFiretruckSiren(veh) and state_lxsiren[veh] == 1 then
							TogMuteDfltSrnForVeh(veh, false)
							dsrn_mute = false
						else
							TogMuteDfltSrnForVeh(veh, true)
							dsrn_mute = true
						end
						
						if not IsVehicleSirenOn(veh) and state_lxsiren[veh] > 0 then
							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
							SetLxSirenStateForVeh(veh, 0)
							count_bcast_timer = delay_bcast_timer
						end
						if not IsVehicleSirenOn(veh) and state_pwrcall[veh] == true then
							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
							TogPowercallStateForVeh(veh, false)
							count_bcast_timer = delay_bcast_timer
						end
					
						----- CONTROLS -----
						if not IsPauseMenuActive() then
						
							-- TOG DFLT SRN LIGHTS
							if IsDisabledControlJustReleased(0, 85) then
								if IsVehicleSirenOn(veh) then
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									SetVehicleSiren(veh, false)
								else
									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									SetVehicleSiren(veh, true)
									count_bcast_timer = delay_bcast_timer
								end		
							
							-- TOG LX SIREN
							elseif IsDisabledControlJustReleased(0, 19) then
								local cstate = state_lxsiren[veh]
								if cstate == 0 then
									if IsVehicleSirenOn(veh) then
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- on
										SetLxSirenStateForVeh(veh, 1)
										count_bcast_timer = delay_bcast_timer
									end
								else
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- off
									SetLxSirenStateForVeh(veh, 0)
									count_bcast_timer = delay_bcast_timer
								end
							
							-- TOG LX SIREN (HORN)
							elseif IsDisabledControlJustReleased(0,86) and HasHornSwitch(veh) then
								local timer = GetGameTimer()
								while true do
									if IsControlJustPressed(0, 86) then
										local cstate = state_lxsiren[veh]
										if cstate == 0 then
											if IsVehicleSirenOn(veh) then
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
							elseif IsDisabledControlJustReleased(0, 82) and HasAuxiliaryTone(veh) then
								if state_pwrcall[veh] == true then
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									TogPowercallStateForVeh(veh, false)
									count_bcast_timer = delay_bcast_timer
								else
									if IsVehicleSirenOn(veh) then
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
										TogPowercallStateForVeh(veh, true)
										count_bcast_timer = delay_bcast_timer
									end
								end
								
							end
							
							-- BROWSE LX SRN TONES
							if state_lxsiren[veh] > 0 then
								if IsDisabledControlJustReleased(0, 80) or (IsDisabledControlJustPressed(0, 86) and HasHornSwitch(veh)) then
									local cstate = state_lxsiren[veh]
									local nstate = 1
									if IsVehicleSirenOn(veh) then
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- on
										if cstate == 1 then
											nstate = 2
										elseif not HasNoTertiaryTone(veh) and cstate == 2 then
											nstate = 3
										else
											nstate = 1
										end
										SetLxSirenStateForVeh(veh, nstate)
										count_bcast_timer = delay_bcast_timer
									end
								end
							end

							-- 	TOG QUARTERNARY TONE
							if IsDisabledControlJustReleased(0, 81) then
								if IsVehicleSirenOn(veh) and HasQuarternaryTone(veh) then
									local cstate = state_lxsiren[veh]
									local nstate = 4
									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- on
									if cstate == 1 then
										pstate = cstate
										nstate = 4
									elseif cstate == 2 then	
										pstate = cstate
										nstate = 4
									elseif cstate == 3 then	
										pstate = cstate
										nstate = 4
									elseif cstate == 4 then	
										nstate = pstate
									end
									SetLxSirenStateForVeh(veh, nstate)
									count_bcast_timer = delay_bcast_timer
								end
							end
										
							-- MANU
							if state_lxsiren[veh] < 1 then
								if IsDisabledControlPressed(0, 80) or IsDisabledControlPressed(0, 81) then
									actv_manu = true
								else
									actv_manu = false
								end
							else
								actv_manu = false
							end

							-- HORN SIREN TOGGLL
							if IsDisabledControlPressed(0, 86) and (not HasHornSwitch(veh) or (HasHornSwitch(veh) and state_lxsiren[veh] == 0))  then
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
							hmanu_state_new = 1
						elseif actv_horn == false and actv_manu == true then
							hmanu_state_new = 2
						elseif actv_horn == true and actv_manu == true then
							hmanu_state_new = 3
						end
						if hmanu_state_new == 1 then
							if not UseFiretruckSiren(veh) then
								if state_lxsiren[veh] > 0 and actv_lxsrnmute_temp == false then
									srntone_temp = state_lxsiren[veh]
									SetLxSirenStateForVeh(veh, 0)
									actv_lxsrnmute_temp = true
								end
							end
						else
							if not UseFiretruckSiren(veh) then
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
						if not IsPauseMenuActive() then
						
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
							if GetVehicleClass(veh) == 18 then
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