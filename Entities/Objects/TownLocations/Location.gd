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

@export var display_name : String = ""
@export var display_description: String = ""

var locData 

var popupOpen = false

var available_secrets = []

var isEmpty = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Icon/DemonIcon.hide()
	
	Globals.Evening.connect(end_day)
	Globals.NewDay.connect(start_day)
	
	Globals.SearchEnded.connect(end_search)

	
	load_secrets()

	pass


func load_secrets():
	var secrets = Globals.Secrets.keys()
	
	for key in secrets.size() - 1:
		
		var secret = secrets[key]
		#check if the secret applies to this location:
		if str(Globals.Secrets[secret].spawn_location) == locationName:
			#check if the secret is already in our library, in which case we don't need to add it
			if !Globals.active_secrets.has(secret) and !Globals.archived_secrets.has(secret):
				
				#if the secret is a standalone secret with no secret to upgrade:
				if Globals.Secrets[secret].secret_to_upgrade == null:
					#add the secret
					available_secrets.append(secret)
				else:
					#if there is a secret to upgrade, check if we already have this secret
					if Globals.active_secrets.has(Globals.Secrets[secret].secret_to_upgrade):
						#if so, add the secret 
						available_secrets.append(secret)
						

	#if there are no more new secrets to add, the location is empty. Player should't be encouraged to search here.
	if available_secrets.size() == 0:
		isEmpty = true
		self_modulate.a = 0.5


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
	
	Audio.play_sound(load(Audio.hover[randi_range(0, 2)]))
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
	
	

	Audio.play_sound(Audio.click)
	var LP = locationPopup.instantiate()
	Globals.HUD.add_child(LP)
	LP.set_up(display_name, display_description, self, isEmpty)
	
func end_search():
	
	$Icon/DemonIcon.hide()
	if Globals.searchLocation == locationName:

		Globals.dayOver = true
		choose_secret()

func choose_secret():
	
	if available_secrets.size() > 0:
		var secret = available_secrets[randi_range(0, available_secrets.size() - 1)]
		
		available_secrets.erase(secret)
		Globals.active_secrets.append(secret)
		Globals.newest_secret = secret
		print("active secrets after search: " + str(Globals.active_secrets))
	
	else: print("Nothing added.")
	
		
		
