extends ProgressBar


@export var searchDuration = 3 		#search duration in seconds
var searchprogress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hide()
	Globals.SearchStarted.connect(startSearch)
	Globals.NewDay.connect(newDay)
	max_value = searchDuration
	value = 0
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Globals.isSearching:
		
		searchprogress += delta
		value = searchprogress
		
		$"../BackgroundNight".self_modulate.a += delta / searchDuration
		if searchprogress >= searchDuration:
			endSearch()
			
			
	pass
	
func newDay():
	$"../BackgroundNight".hide()
	
func startSearch():
	

	Globals.isSearching = true
	max_value = searchDuration
	value = 0
	searchprogress = 0
	show()

func endSearch():

	searchprogress = 0
	value = 0
	
	Globals.isSearching = false
	Globals.emit_signal("SearchEnded")
	hide()
	print("ready search results!")
