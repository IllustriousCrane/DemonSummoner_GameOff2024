extends Control

var caller

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Panel/NightAnnouncement.hide()
	
	if Globals.actionChosen:
		$Panel/SearchButton.disabled = true
		$Panel/NightAnnouncement.show()
		$Panel/SearchButton.modulate.a = 0.4
		

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_up(locationName, locationDescription, callerID, empty):
	
	Globals.popUpOpen = true
	$Panel/Name.text = locationName
	$Panel/Description.text = locationDescription
	caller = callerID
	
	if empty:
		$Panel/SearchButton.disabled = true
		$Panel/SearchButton/Label.text = "There is nothing more to find here."
	
	#TODO: set up icons to indicate who the player might be able to obtain information of here
	pass
	
	#on search button pressed:
func start_search():
	
	Globals.actionChosen = true
	
	#detract energy:
	
	Globals.HUD.get_node("DemonStats").lower_vitality(caller.energy_cost)
	
	#handle trust
	
	if caller.locationName == Globals.demon_desired_location:
		Globals.HUD.get_node("DemonStats").increase_trust(caller.trust_increase_for_desired)
		print("call trust increase, demons desired location is:" + str(Globals.demon_desired_location))
	else:
		Globals.HUD.get_node("DemonStats").lower_trust(caller.trust_decrease)
	
	#start the search
	Globals.emit_signal("SearchStarted")
	Globals.searchLocation = caller.locationName
	
	close()
	pass
	

func close():
	Globals.popUpOpen = false
	$AnimationPlayer.play("fade_out")
	queue_free()
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		queue_free()
	pass # Replace with function body.
