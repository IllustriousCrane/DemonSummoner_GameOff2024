extends Node2D

@export var opponent : String

var opponentPopup = load("res://UI/Scenes/opponentPopup.tscn")
var hover = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Icon.texture = load(Globals.Opponents[opponent].icon_path)
	$ProgressBar.value = Globals.Opponents[opponent].o_reputation
	$Name.text = Globals.Opponents[opponent].o_name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = Globals.Opponents[opponent].o_reputation
	
	if hover and Input.is_action_just_pressed("LeftMouse"):
		_pressed()
	pass


func _pressed() -> void:
	
	var op = opponentPopup.instanitate()
	Globals.HUD.add_child(op)
	
	
	pass # Replace with function body.


func _on_opponent_click_area_mouse_entered() -> void:
	hover = true
	pass # Replace with function body.



func _on_opponent_click_area_mouse_exited() -> void:
	hover = false
	pass # Replace with function body.
