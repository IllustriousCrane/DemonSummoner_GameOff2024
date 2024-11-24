extends Control


@onready var reputationBar = $Panel2/reputationBar
@onready var moneyLabel = $Panel2/MoneyLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Globals.SearchEnded.connect(highlight_demon)
	
	Globals.DialogueStarted.connect(hide)
	Globals.DialogueEnded.connect(show)
	
	match Globals.currentScreen:
		
		"Town":
			$Panel2/demonSprite/demonAnim.play("fade_in")
			$Panel2.show()
		"Intrigue":
			$Panel2.hide()
		"Demon": 
			$Panel2.show()
			
	
	pass # Replace with function body.

func play_hover():
	#Audio.play_sound(load(Audio.hover[randi_range(0, 2)]))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$Panel2/DayLabel.text = "Day " + str(Globals.day)
	moneyLabel.text = str(Globals.money)
	reputationBar.value = Globals.reputation
	pass


func move_to_intrigue() -> void:

	print("Move to intrigue screen!")

	Globals.currentScreen = "Intrigue"
	SceneTransition.change_scene("res://Entities/Stages/Intrigue.tscn")
	pass # Replace with function body.


func move_to_demon() -> void:#

	print("move to summoning screen!")
	Globals.currentScreen = "Demon"
	SceneTransition.change_scene("res://Entities/Stages/SummoningRoom.tscn")

	pass # Replace with function body.


func move_to_town() -> void:


	print("move to town screen!")
	Globals.currentScreen = "Town"
	SceneTransition.change_scene("res://Entities/Stages/Town.tscn")
	pass # Replace with function body.


func EndDay() -> void:
	print ("player is ending the day")

	Globals.day += 1
	Globals.searchLocation = "none"
	Globals.actionChosen = false
	Globals.demon_desired_location = "none"
	
	SceneTransition.change_scene("res://Entities/Stages/Night.tscn")
	
	pass # Replace with function body.
	
func highlight_demon():
	$Panel/DemonButton.set_pulse(true)
	pass


func _on_demon_anim_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "fade_in":
		$Panel2/demonSprite/demonAnim.play("idle")
	pass # Replace with function body.
