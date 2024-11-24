extends Sprite2D

var opponent : String = "marshal"

var isChosen = false
var hover = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if hover and Input.is_action_just_pressed("LeftMouse"):
		isChosen = true
		#adjust the look of the portrait
		modulate.a = 0.4
	pass


func _on_area_2d_mouse_entered() -> void:
	hover = true
	
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	hover = false
	pass # Replace with function body.
