extends Node2D

@export var opponent : String = ""

var opponentPopup = load("res://UI/Scenes/opponentPopup.tscn")
var hover = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Portrait.texture = load(Globals.Opponents[opponent].portrait_path)
	$AttentionIcon.hide()
	
	if Globals.Opponents[opponent].active_secrets.size() > 0:
		$AttentionIcon.show()
	
	
	if Input.is_action_just_pressed("LeftMouse") and hover:
		_pressed()
	pass # Replace with function body.


func _pressed():
	var op = opponentPopup.instantiate()
	Globals.HUD.add_child(op)
	op.set_up(opponent)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_opponent_click_area_mouse_entered() -> void:
	hover = true
	$Portrait/portrait_anim.play("hover")
	pass # Replace with function body.


func _on_opponent_click_area_mouse_exited() -> void:
	hover = false
	pass # Replace with function body.
