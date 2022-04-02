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
	"audio/simplesound_test_sounds.dat54.rel",
	"audio/wsound_game.dat151.rel",
	"audio/wsound_sounds.dat54.rel",

	"audio/serversideaudio_sounds.dat54.rel",
	"audio/sfx/dlc_serversideaudio/rpch_ssa_vehaud_pack1.awc",
	"audio/sfx/dlc_serversideaudio/rpch_ssa_vehaud_pack2.awc",
	"audio/sfx/dlc_serversideaudio/rpch_ssa_vehaud_pack3.awc",
	"audio/sfx/dlc_serversideaudio/rpch_ssa_vehaud_pack4.awc",
	"audio/sfx/dlc_serversideaudio/rpch_ssa_vehaud_pack5.awc",
	"audio/sfx/dlc_serversideaudio/rpch_ssa_vehaud_pack6.awc",
}

-- Weeby Siren Fixes
data_file 'AUDIO_GAMEDATA' 'audio/wsound_game.dat'
data_file "AUDIO_SOUNDDATA" "audio/simplesound_test_sounds.dat"
data_file "AUDIO_SOUNDDATA" "audio/wsound_sounds.dat"

data_file "AUDIO_WAVEPACK" "audio/sfx/dlc_serversideaudio"
data_file "AUDIO_SOUNDDATA" "audio/serversideaudio_sounds.dat54.rel"
