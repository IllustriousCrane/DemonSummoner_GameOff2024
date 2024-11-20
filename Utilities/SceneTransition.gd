extends CanvasLayer

#DESCRIPTION: General scene transition manager, to transition between scenes.
# General transition just changes scenes, teleport transition accounts for there being teleporter nodes to which the player should be moved.


#VARIABLES IN CONJUNCTION WITH TELEPORTER OBJECT for general room transitions ---------------------------------------

var teleporting = false
var target_teleporter = ""

signal Teleport

#-----------------------------------------------------------------------------------------------------------------------

# Called when the node enters the scene tree for the first time.
func _ready():
	$SceneTransitionAnimation.play_backwards("dissolve")
	#change_scene("res://MainMap/map.tscn")
	pass # Replace with function body.

func change_scene(target):
	$SceneTransitionAnimation.play("dissolve")
	await $SceneTransitionAnimation.animation_finished
	get_tree().change_scene_to_file(target)
	$SceneTransitionAnimation.play_backwards("dissolve")
	
func teleport_to_scene(target, targetNode):
	
	teleporting = true
	target_teleporter = targetNode
	
	$SceneTransitionAnimation.play("dissolve")
	Globals.Paused = true
	await $SceneTransitionAnimation.animation_finished

	
	#if we are teleporting to another location in the same scene, reload the current scene, emit teleport signal:
	if get_tree().current_scene.name == target:
		#get_tree().reload_current_scene()
		emit_signal("Teleport")
	
	else:
		get_tree().change_scene_to_file(target)
		
	$SceneTransitionAnimation.play_backwards("dissolve")
	Globals.Paused = false
	
func transitionTime(currentDay, currentTime):
	
	Globals.Paused = true
	Globals.Transitioning = true
	
	var newDay = currentDay + 1
	
	var newTime = ""

	match currentTime:
		"morning":
			newTime = "afternoon"
			$DayLabel.text = "Day " + str(currentDay)
	
			$TimeLabel.text = "Afternoon"
		"afternoon": 
			newTime = "evening"
			$TimeLabel.text = "Evening"
			$DayLabel.text = "Day " + str(currentDay)
		"evening": 
			newTime = "morning" 
			$TimeLabel.text = "Morning"
			$DayLabel.text = "Day " + str(newDay)
		
	$SceneTransitionAnimation.play("dissolve")
	await $SceneTransitionAnimation.animation_finished
	
	#set new day/time

	Globals.changeTime(newTime)

	

	#if new day, move us back to the house
	
	$SceneTransitionAnimation.play("fadeText")
	await get_tree().create_timer(5.0).timeout
	$SceneTransitionAnimation.play_backwards("fadeText")
	await $SceneTransitionAnimation.animation_finished
	$SceneTransitionAnimation.play_backwards("dissolve")

	Globals.Paused = false
	Globals.Transitioning = false
