fx_version 'cerulean'
game 'gta5'

description 'BozLights (boz_vehcontrol)'
author 'Boz, actuallyTOXIC, Lt. Caine, bakerxgooty, crazytaxi1000, Charleszinkey'
version '6.0.0'

client_script 'client.lua'
client_script 'config.lua'
server_script 'server.lua'

files {
	-- Weeby Siren Fixes
	--"data/simplesound_test_sounds.dat54.rel",
	--"data/wsound_game.dat151.rel",
	--"data/wsound_sounds.dat54.rel",

	-- Addon Sounds
	"audio/sfx/dlc_policingmpaudio/policingmp_sirens1.awc",
	"audio/sfx/dlc_policingmpaudio/policingmp_sirens2.awc",
	"audio/data/policingmpaudio_sounds.dat54.rel"
}

-- Weeby Siren Fixes
--data_file 'AUDIO_GAMEDATA' 'data/wsound_game.dat'
--data_file "AUDIO_SOUNDDATA" "data/simplesound_test_sounds.dat"
--data_file "AUDIO_SOUNDDATA" "data/wsound_sounds.dat"

-- Addon Sounds
data_file "AUDIO_WAVEPACK" "audio/sfx/dlc_policingmpaudio"
data_file "AUDIO_SOUNDDATA" "audio/data/policingmpaudio_sounds.dat"
