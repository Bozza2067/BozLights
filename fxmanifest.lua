fx_version 'cerulean'
game 'gta5'

description 'BozLights (boz_vehcontrol)'
author 'Boz, actuallyTOXIC, Lt. Caine, bakerxgooty, crazytaxi1000, Charleszinkey, etc.'
version '6.0.0'

client_script 'client.lua'
client_script 'config.lua'
server_script 'server.lua'

files {
	"audio/**/**/*",
	"audio/**/*"
}

-- Weeby Siren Fixes
data_file 'AUDIO_GAMEDATA' 'audio/data/wsound_game.dat'
data_file "AUDIO_SOUNDDATA" "audio/data/simplesound_test_sounds.dat"
data_file "AUDIO_SOUNDDATA" "audio/data/wsound_sounds.dat"

-- Addon Sounds
data_file "AUDIO_WAVEPACK" "audio/sfx/dlc_policingmpaudio"
data_file "AUDIO_SOUNDDATA" "audio/data/policingmpaudio_sounds.dat"
