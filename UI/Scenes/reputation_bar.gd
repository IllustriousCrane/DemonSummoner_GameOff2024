extends Node2D

@export var opponent : String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Icon.texture = load(Globals.Opponents[opponent].icon_path)
	$ProgressBar.value = Globals.Opponents[opponent].o_reputation
	$Name.text = Globals.Opponents[opponent].o_name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = Globals.Opponents[opponent].o_reputation
	pass
