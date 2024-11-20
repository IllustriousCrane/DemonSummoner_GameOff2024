extends Control


@onready var reputationBar = $Panel2/reputationBar
@onready var moneyLabel = $Panel2/MoneyLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	

	moneyLabel.text = str(Globals.money)
	reputationBar.value = Globals.reputation
	pass


func move_to_intrigue() -> void:
	print("Move to intrigue screen!")
	Globals.emit_signal("screenChanged", "Intrigue")	
	Globals.currentScreen = "Intrigue"
	pass # Replace with function body.


func move_to_demon() -> void:#
	print("move to summoning screen!")
	Globals.emit_signal("screenChanged", "Demon")
	Globals.currentScreen = "Demon"

	pass # Replace with function body.


func move_to_town() -> void:
	Globals.emit_signal("screenChanged", "Town")
	print("move to town screen!")
	Globals.currentScreen = "Demon"
	
	pass # Replace with function body.


func EndDay() -> void:
	print ("player is ending the day")
	pass # Replace with function body.
