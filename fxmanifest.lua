fx_version 'cerulean'
game 'gta5'

description 'BozLights (boz_vehcontrol)'
author 'Boz, ZaygTheRard Lt. Caine'
version '6.0.0'

client_script 'client.lua'
client_script 'config.lua'
server_script 'server.lua'

files {
	-- Weeby Siren Fixes
	"data/simplesound_test_sounds.dat54.rel",
	"data/wsound_game.dat151.rel",
	"data/wsound_sounds.dat54.rel",

	-- Addon Sounds
	"dlc_serversideaudio/oiss_ssa_vehaud_etc.awc",
	"dlc_serversideaudio/oiss_ssa_vehaud_etc2.awc",
	"dlc_serversideaudio/oiss_ssa_vehaud_etc3.awc",
	"dlc_serversideaudio/oiss_ssa_vehaud_etc4.awc",
	"dlc_serversideaudio/oiss_ssa_vehaud_etc5.awc",
	"dlc_serversideaudio/oiss_ssa_vehaud_etc6.awc",
	"data/serversideaudio_sounds.dat54.nametable",
	"data/serversideaudio_sounds.dat54.rel"
}

-- Weeby Siren Fixes
data_file 'AUDIO_GAMEDATA' 'data/wsound_game.dat'
data_file "AUDIO_SOUNDDATA" "data/simplesound_test_sounds.dat"
data_file "AUDIO_SOUNDDATA" "data/wsound_sounds.dat"

-- Addon Sounds
data_file "AUDIO_WAVEPACK" "dlc_serversideaudio"
data_file "AUDIO_SOUNDDATA" "data/serversideaudio_sounds.dat"
