extends Node


@onready var tree := get_tree()


#play a sound from anywhere. Not acknowledging 2D space.
func play_sound(sound: AudioStream, autoplay := true, pitchLow := 1, pitchHigh:= 1) -> AudioStreamPlayer:
	
	var player := AudioStreamPlayer.new()
	
	player.pitch_scale = randf_range(pitchLow, pitchHigh)
	player.bus = "SFX"
	player.stream = sound
	player.autoplay = autoplay
	player.finished.connect(func(): player.queue_free())
	tree.current_scene.add_child(player)
	return player
	

#play a sound from somewhere specific in a 2D space. This function returns the audio player, which can then be positioned where it ought to be.
func play_sound_2d(sound: AudioStream, autoplay := true) -> AudioStreamPlayer2D:
	
	var player := AudioStreamPlayer2D.new()
	player.bus = "SFX"
	player.stream = sound
	player.autoplay = autoplay
	player.finished.connect(func(): player.queue_free())
	tree.current_scene.add_child(player)
	return player
	
