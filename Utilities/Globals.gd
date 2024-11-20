extends Node


#GLOBAL SIGNALS------------------------------------------------------------

signal NewDay 
signal EndDay
signal Evening			#marks the end of the day in so far as the player spends time on the map.
signal screenChanged(screenName)


signal SearchStarted
signal SearchEnded

#GLOBAL VARIABLES----------------------------------------------------------

var menuOpen = false
var popUpOpen = false

var isSearching = false

var currentScreen = "Demon"		# or: "Town" or "Intrigue"

var HUD


#----------------

var day = 0
var last_day = 30 		#the day on which the game ends

var days_to_last_day = last_day - day

#---PLAYER STATS---------------------------

var reputation = 50 		#out of 100
var money = 14000			#money. Value here is the start amount.

#---VIOL STATS----------------

var demon_name = "Viol"		#name given to the demon by the player
var demon_desired_location = "none"

var viol_trust = 20			#how much the demon trusts you
var angry_threshhold = 15 	#the threshhold under which the demon becomes angry and uncooperative
var viol_energy = 50		#how much energy the demon has left



#SECRETS------------------------------------------------------------------

var Secrets					 #Dictionary in which secrets is stored				
var secrets_path

#OPPONENTS-----------------------------------------------------------------

var Opponents = {
	
	"clergyman": {
		
		"o_name" = "Clergyman",
		"o_description" = "A gluttonous hypocrite appealing to the masses sheepish desire for absolution.",
		"o_reputation" = 10,
		"portrait_path" = "res://icon.svg",
		"icon_path" = "res://icon.svg"
	},
	"treasurer": {
		
		"o_name" = "Treasurer",
		"o_description" = "Greedy, calculating, ambitious.",
		"o_reputation" = 10,
		"portrait_path" = "res://icon.svg",
		"icon_path" = "res://icon.svg"
	},
	"marshal": {
		
		"o_name" = "Marshal",
		"o_description" = "A blunt tool, war-mongering and ruthless.",
		"o_reputation" = 10,
		"portrait_path" = "res://icon.svg",
		"icon_path" = "res://icon.svg"
	},
	
}
#---------------------------------------------------------------------------

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	

	#Load in our secret data:
	
	#Secrets = load_json_data_from_scratch(secrets_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_json_data_from_scratch(path: String):

	var file_string = FileAccess.get_file_as_string(path)
	var json_data 
	
	if file_string != null:
		json_data  = JSON.parse_string(file_string)

	else:
		push_warning("load_json_data_from_path failed get_file_as_string for path: ", path)
	
	if json_data == null:
		push_error("load_json_data_from_path failed to parse file data to JSON for ", path)

	return json_data
