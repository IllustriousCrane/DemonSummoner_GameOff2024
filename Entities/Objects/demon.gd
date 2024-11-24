extends Node2D

var demonTextures = [
	"res://Entities/Objects/demon_1.png",
	"res://Entities/Objects/demon_2.png"
]

var speechbubble = load("res://UI/Scenes/SpeechBubble.tscn")

var anim_counter = 0
var anim_max_rounds = 2

var canConverse = true

var hover = false


@onready var chatIcon = $DemonSprite/ChatIcon
@onready var sprite = $DemonSprite
@onready var anim = $DemonSprite/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	chatIcon.hide()
	
	Globals.NewDay.connect(pickIntention)
	sprite.texture = load(demonTextures[randi_range(0, demonTextures.size()-1)])

	if Globals.demon_desired_location == "none":
		pickIntention()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if hover and Input.is_action_just_pressed("LeftMouse"):
		if canConverse:
			spawn_dialogue()
			
	
	if canConverse and hover:
		chatIcon.show()
	else:
		chatIcon.hide()
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:

	
	if anim_name == "idle":
		
		anim_counter += 1
		anim.play("idle")
		if anim_counter >= anim_max_rounds:
			anim_counter = 0

			sprite.texture = load(demonTextures[randi_range(0, demonTextures.size() - 1)])
			anim.play("idle")
		
	pass # Replace with function body.

func pickIntention():
	
	#TODO: expand this list of locations Viol might take an interest in
	
	var locations = ["Church", "Palace", "Library", "Bar", "Theatre"]
	Globals.demon_desired_location = locations[randi_range(0, locations.size()-1)]
	print("Demon's desired location is: " + str(Globals.demon_desired_location))
	
func _on_demon_click_area_mouse_entered() -> void:
	hover = true

	print("hover!")
	pass # Replace with function body.


func _on_demon_click_area_mouse_exited() -> void:
	hover = false

	print("off hover!")
	pass # Replace with function body.

func spawn_dialogue():
	
	var trust = Globals.demon_trust
	var dialogue_choices = []
	#if the demon is distrusting:
	if trust <= 20:
		dialogue_choices = ["Do not touch me, human.",
		"Break the circle - it will suffer consequences.",
		"What does it desire? It bears no relevance.",
		"Mh.",
		"Its blood sings to me.",
		"The heart reveals fear, human.",
		"The contract does not command our engagement."]
	
	elif trust > 20 and trust <= 60:
		dialogue_choices = ["It may step closer - carefully.",
		"Its ambitions are confounding. What is the draw of human power? Lifes futile and fleeting.",
		"Lest it would damage me, there is no cause for alarm.",
		"Curiosity. The human world holds vast amounts of new information.",
		"It seeks the company of one like my own - why?",
		"I grow tired of being confined. Its presence may be stimulating.",
		"Why is its shape consistent?"]
	
	elif trust > 60:
		dialogue_choices = ["Human. You returned.",
		"I feel its warmth through the circle. Its heart is an amusing sound. Pitter-pat.",
		"I do not mind that it approaches without purpose.",
		"It spends valuable time by my side - what of its ambitions?",
		"I may protect.",
		"Its enemies will fall like flies. It is what it desires, yes?",
		"Its secrets are safe with me.",
		"My tendrils stroke its thoughts. Gentle, gentle. Human minds are fragile.",
		"I will do no harm.",
			
		]
		
	var SB = speechbubble.instantiate()
	sprite.add_child(SB)
	SB.global_position.x = sprite.global_position.x + randi_range(-100, 100)
	SB.initiate_text(dialogue_choices[randi_range(0, dialogue_choices.size()-1)])	
	
	canConverse = false
	
