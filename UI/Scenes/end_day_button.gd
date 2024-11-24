extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	disabled = true
	
	Globals.SearchEnded.connect(enable_end_day)
	Globals.NewDay.connect(disable_end_day)
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
