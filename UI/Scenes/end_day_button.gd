extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	disabled = true
	
	if Globals.dayOver:
		disabled = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if disabled:
		modulate.a = 0.4
	
	else:
		modulate.a = 1
	pass

func enable_end_day():
	disabled = false
	
func disable_end_day():
	disabled = true


func _on_pressed() -> void:
	pass # Replace with function body.
