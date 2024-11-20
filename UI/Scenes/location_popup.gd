extends Control

var caller

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_up(locationName, locationDescription, callerID):
	
	Globals.popUpOpen = true
	$Panel/Name.text = locationName
	$Panel/Description.text = locationDescription
	caller = callerID
	
	#TODO: set up icons to indicate who the player might be able to obtain information of here
	pass
	
	#on search button pressed:
func start_search():
	
	#start the search
	Globals.emit_signal("SearchStarted")

	close()
	pass
	

func close():
	Globals.popUpOpen = false
	queue_free()
	
