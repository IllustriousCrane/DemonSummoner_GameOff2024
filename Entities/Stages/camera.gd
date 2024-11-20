extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Globals.screenChanged.connect(updateScreen)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func updateScreen(screen):
	
	match screen:
		"Town": 
			position.x = %Town.position.x + 1920 / 2
			position.y = %Town.position.y + 1080 / 2
		"Demon":
			position.x = %SummoningRoom.position.x + 1920 / 2
			position.y = %SummoningRoom.position.y + 1080 / 2
		"Intrigue":
			position.x = %Intrigue.position.x + 1920 / 2
			position.y = %Intrigue.position.y + 1080 / 2
			
