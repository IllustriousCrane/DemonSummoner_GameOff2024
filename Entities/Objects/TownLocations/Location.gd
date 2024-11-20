extends Node2D


var locationPopup = load("res://UI/Scenes/locationPopup.tscn")
var hover = false

var canInteract = true

@export var locationName = "location"
@export var energy_cost : int = 20		#how much energy searching this location will cost viol
#Resource script to store available secrets and events:
@export var locationResource : Resource

var locData 

var popupOpen = false

var available_secrets = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Globals.Evening.connect(end_day)
	Globals.NewDay.connect(start_day)
	
	
	locData = locationResource.new()

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("LeftMouse") and hover and !Globals.popUpOpen:
		if canInteract:
			open_location()
			
	
	if Globals.demon_desired_location == locationName:
		$DemonIcon.show()
	pass
	
func on_hover():
	hover = true
	modulate.a = 0.5
	pass	
	
func stop_hover():
	modulate.a = 1
	hover = false
	
func start_day():
	canInteract = true
	
func end_day():
	canInteract = false

func open_location():
	var LP = locationPopup.instantiate()
	Globals.HUD.add_child(LP)
	LP.set_up(locData.locationName, locData.locationDescription, self)
