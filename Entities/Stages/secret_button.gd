extends TextureButton

var c_secret

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_up(secret):
	
	print("Setting up secret")
	c_secret = secret
	$Label.text = Globals.Secrets[c_secret].secret_name
	
func _on_pressed() -> void:
	
	#TODO: open secret popup with this secret.
	get_parent().get_parent().show_info(c_secret)
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	Audio.play_sound(load(Audio.hover[randi_range(0, 2)]))
	pass # Replace with function body.
