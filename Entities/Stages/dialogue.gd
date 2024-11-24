extends Control

var speechBubble = load("res://UI/Scenes/SpeechBubble.tscn")

var c_dialogue
var c_page = 0

var dialogue_size = 0

var waiting_to_continue = false

@onready var clickIcon 		#click icon to indicate to the player to click


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_IGNORE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if waiting_to_continue:
		if Input.is_action_just_pressed("LeftMouse") or Input.is_action_just_pressed("Interact"):
			progress_line()
	pass

func start_dialogue(dialogue):
	
	c_page = 0
	c_dialogue = dialogue
	
	Globals.emit_signal("DialogueStarted")
	mouse_filter = MOUSE_FILTER_STOP
	dialogue_size = c_dialogue.size()-1
	
	var sb = speechBubble.instantiate()
	add_child(sb)
	sb.initiate_text(c_dialogue[c_page], true)

func progress_line():
	if c_page < dialogue_size:
		#fade out previous dialogue bubble in the bubble itself
		c_page += 1
		var sb = speechBubble.instantiate()
		add_child(sb)
		sb.initiate_text(c_dialogue[c_page], true)
		pass
	else:
		Globals.emit_signal("DialogueEnded")
		mouse_filter = MOUSE_FILTER_IGNORE
		
	
