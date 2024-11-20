extends TextureButton

@export var sceneName : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.screenChanged.connect(adapt_to_scene)
	
	Globals.SearchEnded.connect(enable)
	Globals.SearchStarted.connect(disable)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if disabled:
		modulate.a = 0.4
	
	else:
		modulate.a = 1
	
	if Globals.currentScreen == sceneName:
		disabled = true
	
	pass

func adapt_to_scene(screenName):
	if screenName == sceneName:
		disabled = true
	else:
		disabled = false
	
func disable():
	disabled = true

func enable():
	if Globals.currentScreen != sceneName:
		disabled = false
