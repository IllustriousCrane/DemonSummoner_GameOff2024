extends Control


@onready var _vitality = $Control/Vitality
@onready var _trust = $Control/Trust

@export var vital_increase_per_day = 10

var isVisible = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	_vitality.value = Globals.demon_energy
	_trust.value = Globals.demon_trust
	
	Globals.NewDay.connect(start_day)
	Globals.screenChanged.connect(changeScene)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func lower_vitality(amount):
	
	print("lowering vitality")
	Globals.demon_energy -= amount
	_vitality.value = Globals.demon_energy

func increase_vitality(amount):
	
	print("increasing vitality")
	Globals.demon_energy += amount
	_vitality.value = Globals.demon_energy


func lower_trust(amount):
	Globals.demon_trust -= amount
	_trust.value = Globals.demon_trust
	
func increase_trust(amount):
	
	Globals.demon_trust += amount
	_trust.value = Globals.demon_trust

func start_day():
	
	increase_vitality(vital_increase_per_day)

func changeScene(screen):
	
	match screen:
		
		"Demon": 
			if !isVisible:
				$AnimationPlayer.play("fade_in")
		"Town": 
			if !isVisible:
				$AnimationPlayer.play("fade_in")
		"Intrigue":
			$AnimationPlayer.play("fade_out")
			isVisible = false
