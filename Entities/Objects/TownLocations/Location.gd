extends Node2D


var locationPopup = load("res://UI/Scenes/locationPopup.tscn")
var hover = false

var canInteract = true

@export var normal_scale = 1
@export var hover_scale = 1.2

@export var locationName = "location"
@export var energy_cost : int = 20		#how much energy searching this location will cost viol
#Resource script to store available secrets and events:
@export var trust_increase_for_desired : int = 20
@export var trust_decrease : int = 5

@export var locationResource : Resource

var locData 

var popupOpen = false

var available_secrets = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Icon/DemonIcon.hide()
	
	Globals.Evening.connect(end_day)
	Globals.NewDay.connect(start_day)
	
	Globals.SearchEnded.connect(end_search)
	
	locData = locationResource.new()

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if Globals.isSearching: return
	
	if Input.is_action_just_pressed("LeftMouse") and hover and !Globals.popUpOpen:
		if canInteract:
			open_location()
			
	if Globals.demon_desired_location == locationName:
		$Icon/DemonIcon.show()
		
	pass
	
func on_hover():
	
	if Globals.isSearching: return
	
	hover = true
	scale.x = hover_scale
	scale.y = hover_scale
	pass	
	
func stop_hover():

	scale.x = normal_scale
	scale.y = normal_scale
	hover = false
	
func start_day():
	canInteract = true
	
func end_day():
	canInteract = false
	$Icon/DemonIcon.hide()

func open_location():
	var LP = locationPopup.instantiate()
	Globals.HUD.add_child(LP)
	LP.set_up(locData.locationName, locData.locationDescription, self)

func end_search():
	
	$Icon/DemonIcon.hide()
	if Globals.searchLocation == locationName:

		locData.choose_secret()
